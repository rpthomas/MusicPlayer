//
//  ResourceAPI.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/9/21.
//

// 1
import StoreKit
 
// 2
class ResourceAPI {
    
    public var EverLeapKeyUrl: String = "http://6989-47652.el-alt.com/MainService.asmx/GetKey"
    public var EverLeapUserDefaultUrl: String = "http://6989-47652.el-alt.com/MainService.asmx/CheckDefaultReset"


    var developerToken:String = ""
    var returnedUserToken: String = ""
    var attempts: Int = 0

    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

    func getDefaultReset() {
            guard let url = URL(string: EverLeapUserDefaultUrl) else {
                print("Error: cannot create URL")
                return
            }
            // Create the url request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { data, response, error in
                print(response as Any)
                
                

                guard error == nil else {
                    print("Error: error calling GET")
                    print(error!)
                    return
                }
                
                
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
               
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let responseJSON = responseJSON as? [[String: Any]] {
                            print(responseJSON)
                        }
                    
                if let returnData = String(data: data, encoding: .utf8) {
                          print(returnData)
                }
                    return
                }
                do {
                    
         
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String : Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    
                    for (key, value) in jsonObject {
                        print("\(key) -> \(value)")
                        
                        print(type(of: value))

                        let v:String = value as! String
                        let components = v.components(separatedBy: ",")

                          //  var val: String = asp["DeveloperToken"]! as! String
                        print(components)
                        var nextFlag = false
                        for item in components {
                            print(item)
                            if item.contains("DefaultFlag")
                            {
                                if let i = item.firstIndex(of: ":") {
                                    let _: Int = item.distance(from: item.startIndex, to: i)
                                    
                                    let k = Int(item.suffix(1))
                                    print(k!)
                                    
                                    var wholeString:String = item
                                    print(wholeString.remove(at: i))
                                    
                                    let defaults = UserDefaults.standard
                                    defaults.set(k, forKey: "UpdateFlag")
                                    
                                    
                                    defaults.synchronize()
                                }
                                nextFlag = true
                            }
                            else if nextFlag == true
                                {
                                if item.contains("Date")
                                {
                                    var k:String = ""
                                    nextFlag = false

                                        if let i = item.firstIndex(of: ":") {
                                          let index: Int = item.distance(from: item.startIndex, to: i)
                                            
                                            let wholeString:String = item
                                            print(wholeString)
                                            k = String(wholeString.dropFirst(index + 1))
                                            print(k)
                                            
                                            k = k.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                print(k)
                                            

                                            let defaults = UserDefaults.standard
                                            defaults.set(k, forKey: "KeyDate")
                                            defaults.synchronize()
                                        }
                                }
                                   
                            }
                            else
                            {
                                //Do Nothing
                                break
                            }
                            
                        }
                        self.CompareSettings()
                    }
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    func CompareSettings()
    {
        let defaults = UserDefaults.standard
        var keyDate:String
        var lastRunDate:String
        
        if defaults.object(forKey: "KeyDate") != nil &&
            defaults.object(forKey: "LastUpdateDate") != nil
        {
            
            keyDate = defaults.string(forKey: "KeyDate")!
            lastRunDate = defaults.string(forKey: "LastUpdateDate")!
            
            guard let date1 = keyDate.toDate() else {
                        print("dateString1: \(keyDate) | Failed to cast to \"mm/dd/yyyy\"")
                        return
                    }

            guard let date2 = lastRunDate.toDate() else {
                print("dateString2: \(lastRunDate) | Failed to cast to \"mm/dd/yyyy  hh:mm\"")
                return
            }
            if date1 > date2
            {
                defaults.removeObject(forKey: "UserToken")
                defaults.set(keyDate, forKey: "LastUpdateDate")

            }
        }
        else if defaults.object(forKey: "LastUpdateDate") == nil
        {
            keyDate = defaults.string(forKey: "KeyDate")!
            defaults.removeObject(forKey: "UserToken")
            defaults.set(keyDate, forKey: "LastUpdateDate")
        }

    }

}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: self)
    }
}

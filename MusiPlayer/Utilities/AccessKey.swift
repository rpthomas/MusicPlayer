//
//  AccessKey.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 6/10/21.
//

import UIKit

class AccessKey: NSObject {
    var EverLeapKeyUrl: String = ""
    var publicKey: String = ""

    func getMethod() {
        
        let res = ResourceAPI()
        EverLeapKeyUrl = res.EverLeapKeyUrl
        
            guard let url = URL(string: EverLeapKeyUrl) else {
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
                        let components = v.components(separatedBy: ":")

                          //  var val: String = asp["DeveloperToken"]! as! String
                        print(components)
                        var nextFlag = false
                        for item in components {
                            print(item)
                            if item.contains("DeveloperToken")
                            {
                                nextFlag = true
                            }
                            else if nextFlag == true
                                {
                                var k = item
                                nextFlag = false

                                    if let i = item.firstIndex(of: ",") {
                                      let index: Int = item.distance(from: item.startIndex, to: i)
                                        k = String(item.prefix(index))
                                        print(k)
                                        
                                        DispatchQueue.main.async {
                                            let defaults = UserDefaults.standard
                                            defaults.set(k as String, forKey: "DeveloperToken")
                                            self.publicKey = k
                                            let rd = ReadWrite()
                                            rd.writeText(str: k)
                                            print(self.publicKey)
                                            defaults.synchronize()
                                        }
                                        
                                    }
                                   
                                }
                            else
                            {
                                var replaced = item.replacingOccurrences(of: "\\r", with: "\r")
                                replaced = replaced.replacingOccurrences(of: "\\n", with: "\n")
                                replaced = replaced.replacingOccurrences(of: "\r\n", with: "\n")
                                replaced = replaced.replacingOccurrences(of: "0026", with: " & ")
                                replaced = replaced.replacingOccurrences(of: "Item", with: "")
                                replaced = replaced.replacingOccurrences(of: "Q\\u", with: "Q")
                                replaced = replaced.replacingOccurrences(of: "\"", with: "")
                                replaced = replaced.replacingOccurrences(of: ".,", with: "")

                                
                                let defaults = UserDefaults.standard
                                defaults.set(replaced as String, forKey: "About")
                                defaults.synchronize()
                                break
                            }
                            
                        }
                        
                    }
                    
                   // var dict:[String: Any] = jsonObject
//                    if (jsonObject as [String: Any]) != nil {
//                        //var key: String = val["DeveloperToken"]!
//                        //var about: String = val["About"]!
//                                print("sdf")
//                    }
//
//                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                        print("Error: Cannot convert JSON object to Pretty JSON data")
//                        return
//                    }
//                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                        print("Error: Could print JSON in String")
//                        return
//                    }
                    
                    //print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    


}


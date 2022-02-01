//
//  AppleMusicAPI.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/9/21.
//

// 1
import StoreKit
import Foundation

enum AppleConnectError: Error {
    case noDataReturned(String)
    case unexpectedError(String)
}
 
// 2
class AppleMusicAPI {
    var EverLeapKeyUrl: String = "" 

    var developerToken:String = ""
    var returnedUserToken: String = ""
    var attempts: Int = 0

    // 4
    func getUserToken()  { //-> String
        var userToken = String()
 
        
        let rd = ReadWrite()
        developerToken = rd.readText()
        print(developerToken)
        developerToken = developerToken.replacingOccurrences(of: "\"", with: "")
        
        if developerToken == ""
        {
            let defaults = UserDefaults.standard
            developerToken = defaults.string(forKey: "DeveloperToken") ?? ""
            rd.writeText(str: developerToken)
        }
        print(developerToken)
            SKCloudServiceController().requestUserToken(forDeveloperToken: developerToken) { (receivedToken, error) in
                print(receivedToken as Any)

                guard error == nil else {
                    if error.debugDescription.contains("The latest Apple privacy policy has yet to be acknowledged")
                    {
                        self.showNotLoggedIntoMusic()
                    }
                    return
                    
                }
                
                if let token = receivedToken {
                    userToken = token
                    self.returnedUserToken = userToken
                    let defaults = UserDefaults.standard
                    defaults.set(self.returnedUserToken, forKey: "UserToken")
                    print(userToken)
                    defaults.synchronize()
                }
           // }
        }
         
        //return userToken
    }
    
    
    func fetchStorefrontID() -> String {

                        
        
        let lock = DispatchSemaphore(value: 0)
        
        let rd = ReadWrite()
        developerToken = rd.readText()
        developerToken = developerToken.replacingOccurrences(of: "\"", with: "")

        print("Developer Token: " + developerToken);

        
        var storefrontID: String!
     
        let defaults = UserDefaults.standard
        if UserDefaults.standard.object(forKey: "UserToken") != nil
        {
            returnedUserToken = defaults.object(forKey: "UserToken")! as! String
            print(returnedUserToken)
        }
        else
        {
            return ""
        }
        
        // 2
        let musicURL = URL(string: "https://api.music.apple.com/v1/me/storefront")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        

        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        
           musicRequest.addValue(returnedUserToken, forHTTPHeaderField: "Music-User-Token")
     
        // 3
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else {
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    if httpStatus.statusCode == 403 && self.attempts == 0
                    {
                        self.attempts = 1
                        self.getUserToken()
                        self.showNoKeyAlert()
                    }
                }
                return
            }
     
            // 4
            
            do {
                if let json = try? JSON(data: data!){
                    let any : Any? = json
                    if any != nil
                    {
                        // 1
                        print((json["data"]).array!)
                        let result = (json["data"]).array!
                        let id = (result[0].dictionaryValue)["id"]!
                         
                        // 2
                        storefrontID = id.stringValue
                         
                        // 3
                        lock.signal()
                    }
                    else
                    {
                        throw AppleConnectError.noDataReturned("No Data Returned")

                    }
                }
                else
                {
                    throw AppleConnectError.noDataReturned("No Data Returned")
                }
                
            } catch AppleConnectError.noDataReturned {
                let alert = UIAlertController(title: "Error Occurred", message: "No Data Returned", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
                    
            }  catch {
                let alert = UIAlertController(title: "Error Occurred", message: "Unexpected Error", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                UIApplication.topViewController()?.present(alert, animated: true, completion: nil)

            }

        }.resume()
     
        // 5
        lock.wait()
        return storefrontID
    }
    
    func searchAppleMusic(_ searchTerm: String!, completion: @escaping ([Song]?) -> Void)   {

        let rd = ReadWrite()
        developerToken = rd.readText()
        developerToken = developerToken.replacingOccurrences(of: "\"", with: "")
                
        //let lock = DispatchSemaphore(value: 0)
        //var songs: Song?
        var songArray = [Song]()
        var next: String?
        var str: String = ""
     
        let defaults = UserDefaults.standard
        if UserDefaults.standard.object(forKey: "UserToken") != nil
        {
            returnedUserToken = defaults.object(forKey: "UserToken")! as! String
            print(returnedUserToken)
        }
        else
        {
            return
        }


        
        let musicURL = URL(string: "https://api.music.apple.com/v1/catalog/\(fetchStorefrontID())/search?term=\(searchTerm.replacingOccurrences(of: " ", with: "+"))&types=songs&limit=25")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        print(returnedUserToken)

        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
            musicRequest.addValue(returnedUserToken, forHTTPHeaderField: "Music-User-Token")
     
        let task = URLSession.shared.dataTask(with: musicRequest) { data, response, error in

                    guard let data = data, error == nil else {
                        print("error=\(String(describing: error))")
                        return
                    }

                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(String(describing: response))")
                        if httpStatus.statusCode == 403 && self.attempts == 0
                        {
                            self.attempts = 1
                            self.getUserToken()
                            self.showNoKeyAlert()
                        }
                    }
            
            do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    if let dictionary = jsonObject as? [String: Any],
                        let results = dictionary["results"] as? [String: Any] {
                        for (key,value) in results
                        {
                            print(value)
                            print(key)
                            print(type(of: value))


                            if key == "songs"
                            {
                                
                                let val:[String:Any] = value as! [String : Any]
                                
                                print(val["next"] as Any)
                                if let _ = val["next"] {
                                    next = (val["next"] as! String)
                                    var index: Int = 0
                                    var index2: Int = 0

                                    if let range: Range<String.Index> = next!.range(of: "offset") {
                                        index = next!.distance(from: next!.startIndex, to: range.lowerBound)
                                        index += 7
                                        if let range2: Range<String.Index> = next!.range(of: "&") {
                                            index2 = next!.distance(from: next!.startIndex, to: range2.lowerBound)

                                            var counter: Int = 0
                                            var nextcount :Int = 0
                                            
                                            for char in next!
                                            {
                                                if counter >= index && counter < index2
                                                {
                                                    nextcount += 1
                                                    str = str + String(char)
                                                }
                                                counter += 1
                                                print("character = \(char)")
                                            }
                                        }
                                            //print("index: ", index) //index: 2
                                        }
                                }
                                
                                for (_, value) in val
                                {
                                    print(val)
                                    if let swiftArray = value as? [Any]  {
                                        for (item) in swiftArray
                                        {
                                            if let dict = item as? [String: Any] {
                                                for (key, value) in dict{
                                                    print(value)
                                                    if (key == "attributes")
                                                    {
                                                        if let innerDict = value as? [String: Any] {
                                                            var songs:Song? = (Song(dictionary: innerDict)!)
                                                            if songs != nil{
                                                                songs?.nextPage = str
                                                                print(songs as Any)
                                                                songArray.append(songs!)
                                                                
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                            }

                                        }
                                        completion(songArray)

                                        // Use swiftArray here
                                        print(swiftArray)
                                    }

                                }

                            }

                        }
                        
                    }
                } catch {
                    print("JSONSerialization error:", error)
                }


               }
                task.resume()
        //return songArray
            }
        
    func searchAppleMusicNext(_ searchTerm: String!, next: String, completion: @escaping ([Song]?) -> Void)   {

        let rd = ReadWrite()
        developerToken = rd.readText()
        developerToken = developerToken.replacingOccurrences(of: "\"", with: "")
     
        //let lock = DispatchSemaphore(value: 0)
        //var songs: Song?
        var songArray = [Song]()
     
        let defaults = UserDefaults.standard
        if UserDefaults.standard.object(forKey: "UserToken") != nil
        {
            returnedUserToken = defaults.object(forKey: "UserToken")! as! String
        }
        else
        {
            return
        }
        
        let musicURL = URL(string: "https://api.music.apple.com/v1/catalog/\(fetchStorefrontID())/search?offset=\(next)&term=\(searchTerm.replacingOccurrences(of: " ", with: "+"))&types=songs&limit=25")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        print(returnedUserToken)
        
       
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
            musicRequest.addValue(returnedUserToken, forHTTPHeaderField: "Music-User-Token")
     
        let task = URLSession.shared.dataTask(with: musicRequest) { data, response, error in

                    guard let data = data, error == nil else {
                        print("error=\(String(describing: error))")
                        return
                    }

                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(String(describing: response))")
                        if httpStatus.statusCode == 403 && self.attempts == 0
                        {
                            self.attempts = 1
                            self.getUserToken()
                            self.showNoKeyAlert()
                        }
                    }
            
            do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    if let dictionary = jsonObject as? [String: Any],
                        let results = dictionary["results"] as? [String: Any] {
                        for (key,value) in results
                        {
                            if key == "songs"
                            {
                                let val:[String:Any] = value as! [String : Any]
                                for (_, value) in val
                                {
                                    if let swiftArray = value as? [Any]  {
                                        for (item) in swiftArray
                                        {
                                            if let dict = item as? [String: Any] {
                                                for (key, value) in dict{
                                                    if (key == "attributes")
                                                    {
                                                        if let innerDict = value as? [String: Any] {
                                                            let songs:Song? = (Song(dictionary: innerDict)!)
                                                            if songs != nil{
                                                                print(songs as Any)
                                                                songArray.append(songs!)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        completion(songArray)

                                        // Use swiftArray here
                                        print(swiftArray)
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("JSONSerialization error:", error)
                }


               }
                task.resume()
        //return songArray
            }
        
        func showNoKeyAlert()
        {
            let alert = UIAlertController(title: "Problem Encountered", message: "Please Re-Try.", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancelButton)
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    
    func showNotLoggedIntoMusic()
    {
        let alert = UIAlertController(title: "Problem Encountered", message: "You May Not Be Logged into Apple Music.", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
        
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
                                        
                                        let defaults = UserDefaults.standard
                                        defaults.set(k, forKey: "DeveloperToken")
                                        defaults.synchronize()
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
                                
                                
                                AppleMusicAPI().getUserToken()

                                
                                break
                            }
                            
                        }

                    }
                    
 
                    
                    //print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
}

extension NSDictionary {
    var swiftDictionary: Dictionary<String, Any> {
        var swiftDictionary = Dictionary<String, Any>()

        for key : Any in self.allKeys {
            let stringKey = key as! String
            if let keyValue = self.value(forKey: stringKey){
                swiftDictionary[stringKey] = keyValue
            }
        }

        return swiftDictionary
    }
}
extension UIApplication {
class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
        return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
        if let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
    }
    if let presented = controller?.presentedViewController {
        return topViewController(controller: presented)
    }
    return controller
}
    
}

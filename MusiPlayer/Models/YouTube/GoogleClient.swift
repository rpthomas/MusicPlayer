//
//  GoogleClient.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/24/21.
//

import Foundation

struct GoogleClient
{
    // 1
    func fetchChannelsList(forUsername: String,  completion: @escaping ([String: Any]?) -> Void)
    {
        
        let searchEndpoint = GoogleEndpoint.channels(forUsername: forUsername)
        
        
        let searchUrlRequest = searchEndpoint.request
        
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                print(type(of: jsonResponse))
                
                
                guard let json = jsonResponse,
                                     
                      let resultDictionaries:[String : Any] = (json as? [String : Any]?)! else {
                                       //completion(nil)
                                       return
                               }
                        print(type(of: resultDictionaries))
                        print(resultDictionaries)
                // 4. create an array of apps
                //let chan = resultDictionaries.compactMap({ appDictionary in
                    //return resultDictionaries
                //})
                
                // 5. call completion
                completion(resultDictionaries)
            }
        }
    }
    
    
    // 2
    func fetchPlayList(bychannelId: String,  completion: @escaping ([PlaylistsGoogle]?) -> Void)
    {
        
        let searchEndpoint = GoogleEndpointB.playlists(channelId:  bychannelId)
        
        
        let searchUrlRequest = searchEndpoint.request
        
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries:[String : Any] = (json as? [String : Any]?)! else {
                                       //completion(nil)
                                       return
                               }
                        print(type(of: resultDictionaries))
                        print(resultDictionaries)
                
                // 4. create an array of apps
                var plistArray = [PlaylistsGoogle]()
                let nextPageToken:String = resultDictionaries["nextPageToken"] as! String? ?? ""
                let prevPageToken:String = resultDictionaries["prevPageToken"] as! String? ?? ""

                for (key, value) in resultDictionaries {
                    print(key)
                    print(value)
                    if key == "items"
                    {
                        print(type(of: value))

                        if let swiftArray = value as! NSArray as? [Any] {

                            // Use swiftArray here
                            print(swiftArray)
                            for itm in swiftArray
                            {
                                let plist = PlaylistsGoogle(dictionary: itm as! [String : Any], nextPageToken : nextPageToken, prevPageToken: prevPageToken )
                                if (plist != nil)
                                {
                                    plistArray.append(plist!)
                                    print(plistArray.count)
                                }
                                
                            }
                        }

                        
                    }
                }

                
                 // 5. call completion
                completion(plistArray)
            }
        }
    }
    
    func fetchPlayNextList(bychannelId: String, withNextPage: String, completion: @escaping ([PlaylistsGoogle]?) -> Void)
    {
        
        let searchEndpoint = GoogleEndpointB.playlistsNext(channelId:  bychannelId, withNextPage: withNextPage)
        
        
        let searchUrlRequest = searchEndpoint.request
        
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries:[String : Any] = (json as? [String : Any]?)! else {
                                       //completion(nil)
                                       return
                               }
                        print(type(of: resultDictionaries))
                        print(resultDictionaries)
                
                // 4. create an array of apps
                var plistArray = [PlaylistsGoogle]()
                let nextPageToken:String = resultDictionaries["nextPageToken"] as! String? ?? ""
                let prevPageToken:String = resultDictionaries["prevPageToken"] as! String? ?? ""

                for (key, value) in resultDictionaries {
                    print(key)
                    print(value)
                    if key == "items"
                    {
                        print(type(of: value))

                        if let swiftArray = value as! NSArray as? [Any] {

                            // Use swiftArray here
                            print(swiftArray)
                            for itm in swiftArray
                            {
                                let plist = PlaylistsGoogle(dictionary: itm as! [String : Any], nextPageToken : nextPageToken, prevPageToken: prevPageToken )
                                if (plist != nil)
                                {
                                    plistArray.append(plist!)
                                    print(plistArray.count)
                                }
                                
                            }
                        }

                        
                    }
                }

                
                 // 5. call completion
                completion(plistArray)
            }
        }
    }
    
    // 
    func fetchPlayListItems(byPlayListlId: String,  completion: @escaping ([PlaylistsGoogle]?) -> Void)
    {
        
        let searchEndpoint = GoogleEndpointB.playlistsItems(playListID:  byPlayListlId)
        
        
        let searchUrlRequest = searchEndpoint.request
        
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries:[String : Any] = (json as? [String : Any]?)! else {
                                       //completion(nil)
                                       return
                               }
                        print(type(of: resultDictionaries))
                        print(resultDictionaries)
                
                // 4. create an array of apps
                var plistArray = [PlaylistsGoogle]()
                let nextPageToken:String = resultDictionaries["nextPageToken"] as! String? ?? ""
                let prevPageToken:String = resultDictionaries["prevPageToken"] as! String? ?? ""

                for (key, value) in resultDictionaries {
                    print(key)
                    print(value)
                    if key == "items"
                    {
                        print(type(of: value))

                        if let swiftArray = value as! NSArray as? [Any] {

                            // Use swiftArray here
                            print(swiftArray)
                            for itm in swiftArray
                            {
                                let plist = PlaylistsGoogle(dictionary: itm as! [String : Any], nextPageToken : nextPageToken, prevPageToken: prevPageToken )
                                if (plist != nil)
                                {
                                    plistArray.append(plist!)
                                    print(plistArray.count)
                                }
                                
                            }
                        }

                        
                    }
                }

                
                 // 5. call completion
                completion(plistArray)
            }
        }
    }
    
    func fetchPlayListItemsNext(byPlayListlId: String, withNextPage: String,  completion: @escaping ([PlaylistsGoogle]?) -> Void)
    {
        
        let searchEndpoint = GoogleEndpointB.playlistsItemsNext(playListID:  byPlayListlId, withNextPage: withNextPage )
        
        
        let searchUrlRequest = searchEndpoint.request
        
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries:[String : Any] = (json as? [String : Any]?)! else {
                                       //completion(nil)
                                       return
                               }
                        print(type(of: resultDictionaries))
                        print(resultDictionaries)
                
                // 4. create an array of apps
                var plistArray = [PlaylistsGoogle]()
                let nextPageToken:String = resultDictionaries["nextPageToken"] as! String? ?? ""
                let prevPageToken:String = resultDictionaries["prevPageToken"] as! String? ?? ""

                for (key, value) in resultDictionaries {
                    print(key)
                    print(value)
                    if key == "items"
                    {
                        print(type(of: value))

                        if let swiftArray = value as! NSArray as? [Any] {

                            // Use swiftArray here
                            print(swiftArray)
                            for itm in swiftArray
                            {
                                let plist = PlaylistsGoogle(dictionary: itm as! [String : Any], nextPageToken : nextPageToken, prevPageToken: prevPageToken )
                                if (plist != nil)
                                {
                                    plistArray.append(plist!)
                                    print(plistArray.count)
                                }
                                
                            }
                        }

                        
                    }
                }

                
                 // 5. call completion
                completion(plistArray)
            }
        }
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
}










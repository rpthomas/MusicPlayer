//
//  AppStoreClient.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/5/21.
//

import Foundation

struct AppStoreClient
{
    func fetchApps(withTerm term: String, inEntity entity: String, completion: @escaping ([App]?) -> Void)
    {
        print("2")
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        let searchUrlRequest = searchEndpoint.request
        
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                guard let json = jsonResponse,
                    let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let apps = resultDictionaries.compactMap({ appDictionary in
                    return App(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(apps)
            }
        }
    }
}















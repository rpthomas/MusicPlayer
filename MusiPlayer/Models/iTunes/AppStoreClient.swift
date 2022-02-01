//
//  AppStoreClient.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/5/21.
//

import Foundation

struct AppStoreClient
{
    // 1
    func fetchApps(withTerm term: String, inEntity entity: String,  completion: @escaping ([App]?) -> Void)  //inMedia media: String,
    {
        
        let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
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
    
    // 2
    func fetchApps(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([App]?) -> Void)  //inMedia media: String,
    {
        
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
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
    
    // 3
    func fetchApps(inCountry country: String, withTerm term: String, inEntity entity: String,  completion: @escaping ([App]?) -> Void)
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchB(country: country, term: term, entity: entity)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
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
    
    // 4
    func fetchApps(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String,  completion: @escaping ([App]?) -> Void)  //inMedia media: String,
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchC(country: country, term: term, entity: entity, media: media)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
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
    
    
    func fetchAudioBooks(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([AudioBook]?) -> Void)
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                    let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let books = resultDictionaries.compactMap({ appDictionary in
                    return AudioBook(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(books)
            }
        }
    }
    
    func fetchMedia(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([Media]?) -> Void)  //inMedia media: String,
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let media = resultDictionaries.compactMap({ appDictionary in
                    
                    return Media(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(media)
            }
        }
    }
    
    func fetchMovies(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([Movies]?) -> Void)  //inMedia media: String,
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let movies = resultDictionaries.compactMap({ appDictionary in
                    
                    return Movies(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(movies)
            }
        }
    }
    
    func fetchMovieArtists(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([Movies]?) -> Void)  //inMedia media: String,
    {
       
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let movies = resultDictionaries.compactMap({ appDictionary in
                    
                    return Movies(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(movies)
            }
        }
    }
    
    func fetchMusicAlbums(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([Music]?) -> Void)  //inMedia media: String,
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let music = resultDictionaries.compactMap({ appDictionary in
                    
                    return Music(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(music)
            }
        }
    }
    
    
    func fetchMusicArtists(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([Music]?) -> Void)  //inMedia media: String,
    {
       
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let music = resultDictionaries.compactMap({ appDictionary in
                    
                    return Music(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(music)
            }
        }
    }
    
    
    func fetchMusicTrack(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([Music]?) -> Void)  //inMedia media: String,
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let music = resultDictionaries.compactMap({ appDictionary in
                    
                    return Music(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(music)
            }
        }
    }
    
    func fetchMusicVideos(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([MusicVideo]?) -> Void)  //inMedia media: String,
    {
       
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let musicVid = resultDictionaries.compactMap({ appDictionary in
                    
                    return MusicVideo(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(musicVid)
            }
        }
    }
    
    func fetchPodcasts(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([Podcast]?) -> Void)
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let podcast = resultDictionaries.compactMap({ appDictionary in
                    
                    return Podcast(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(podcast)
            }
        }
    }
    
    
    func fetchMusicVideoArtists(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([MusicVideoArtist]?) -> Void)  //inMedia media: String,
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let musicVidArt = resultDictionaries.compactMap({ appDictionary in
                    
                    return MusicVideoArtist(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(musicVidArt)
            }
        }
    }
    
    
    func fetchpodcastAuthor(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([PodcastAuthor]?) -> Void)
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let podAuthor = resultDictionaries.compactMap({ appDictionary in
                    
                    return PodcastAuthor(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(podAuthor)
            }
        }
    }
    
    func fetchSoftwareDev(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([SoftwareDeveloper]?) -> Void)  //inMedia media: String,
    {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                      let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let softDev = resultDictionaries.compactMap({ appDictionary in
                    
                    return SoftwareDeveloper(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(softDev)
            }
        }
    }
    
    func fetchTV(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String,  completion: @escaping ([Television]?) -> Void)  //inMedia media: String,
    {
        
        let searchEndpoint = AppStoreEndpoint.searchA(country: country, term: term, entity: entity, media: media, attribute: attribute)
        
        //let searchEndpoint = AppStoreEndpoint.search(term: term, entity: entity)
        
        
        let searchUrlRequest = searchEndpoint.request
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        print(searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                print(jsonResponse as Any)
                guard let json = jsonResponse,
                    let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let tv = resultDictionaries.compactMap({ appDictionary in
                    return Television(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(tv)
            }
        }
    }
    
}

















//
//  AppStoreEndpoint.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/5/21.
//

import Foundation

// example: https://itunes.apple.com/search?term=iron man&entity=...&country=japan

enum AppStoreEndpoint
{
    case search(term: String, entity: String)
    
    //AudioBook
    case searchA(country: String, term: String, entity: String, media: String, attribute: String)
    
    case searchB(country: String, term: String, entity: String)
    
    case searchC(country: String, term: String, entity: String, media: String)

   
    
        var request: URLRequest {
            var components = URLComponents(string: baseURL)!
            components.path = path
            components.queryItems = queryComponents
            
            let url = components.url!
            return URLRequest(url: url)
        }
    
        private var baseURL: String {
            return "https://itunes.apple.com/"
        }
    
        private var path: String {
            switch self {
            case .search: return "/search"
            case .searchA: return "/search"
            case .searchB: return "/search"
            case .searchC: return "/search"
            }
        }
    
        private struct ParameterKeys {
            static let country = "country"
            static let term = "term"
            static let entity = "entity"
            static let media = "media"
            static let limit = "limit"
            static let attribute = "attribute"
        }
    
        private struct DefaultValues {
            static let country = "us"
            static let term = "apple"
            static let media = "music"
            static let limit = "60"
            static let attribute = "albumTerm"
        }
    
    // ["term" : "instagram", "entity" : "software", "country" : "us"]
        private var parameters: [String : Any] {
            switch self {
            case .search(let term, let entity): //, let media
                let parameters: [String : Any] = [
                    ParameterKeys.term : term,
                    ParameterKeys.country : DefaultValues.country,
                    ParameterKeys.entity : entity
                ]
                
                return parameters
            case .searchA(let country, let term, let entity, let media, let attribute):
                
                let countryCheck = country != "" ? country : DefaultValues.country
                let parameters: [String : Any] = [
                    ParameterKeys.term : term,
                    ParameterKeys.country : countryCheck,
                    ParameterKeys.entity : entity,
                    ParameterKeys.media : media,
                    ParameterKeys.attribute : attribute
                ]
                return parameters
                
            case .searchB(let country, let term, let entity):
                
                let countryCheck = country != "" ? country : DefaultValues.country
                let parameters: [String : Any] = [
                    ParameterKeys.term : term,
                    ParameterKeys.country : countryCheck,
                    ParameterKeys.entity : entity
                ]
                
                return parameters
                
            case .searchC(let country, let term, let entity, let media):
                
                let countryCheck = country != "" ? country : DefaultValues.country
                let parameters: [String : Any] = [
                    ParameterKeys.term : term,
                    ParameterKeys.country : countryCheck,
                    ParameterKeys.entity : entity,
                    ParameterKeys.media : media
                ]
                return parameters
            }
            
        }
    
        private var queryComponents: [URLQueryItem] {
            var components = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.append(queryItem)
                print(queryItem)
            }
            
            return components
        }
    
    //===================================================
    
    
    
    
}




























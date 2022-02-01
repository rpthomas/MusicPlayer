//
//  SoftwareDeveloper.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/20/21.
//

import Foundation

struct SoftwareDeveloper
{
    var wrapper: String?
    var kind: String?
    var sellerName: String?
    var trackName: String?
    var releaseDate: String?
    var trackViewUrl: URL?
    var artwork: URL?
    var price: Double?
    var genres: [String]?
    var primaryGenre: String?
    var description: String?
    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let kind = "kind"
        static let sellerName = "sellerName"
        static let trackName = "trackName"
        static let releaseDate = "releaseDate"
        static let trackViewUrl = "trackViewUrl"
        static let artwork = "artworkUrl60"
        static let price = "price"
        static let description = "description"
        static let genres = "genres"
        static let primaryGenre = "primaryGenreName"
        
    }
    
    init?(dictionary: [String : Any])
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String ?? "" as String?,
            let kind = dictionary[APIKeys.kind] as? String ?? "" as String?,
            let sellerName = dictionary[APIKeys.sellerName] as? String ?? "" as String?,
            let trackName = dictionary[APIKeys.trackName] as? String ?? "" as String?,
            let releaseDate = dictionary[APIKeys.releaseDate] as? String ?? "" as String?,
            let trackViewUrl = dictionary[APIKeys.trackViewUrl] as? String ?? "" as String?,
            let artwork = dictionary[APIKeys.artwork] as? String ?? "" as String?,
            let price = dictionary[APIKeys.price] as? Double ?? 0.00 as Double?,
            let genres = dictionary[APIKeys.genres] as? [String],
            let description = dictionary[APIKeys.description] as? String ?? "" as String?,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String ?? "" as String?

            else {
            return nil
        }
        
        self.wrapper = wrapper
        self.kind = kind
        self.sellerName = sellerName
        self.trackName = trackName
        self.releaseDate = releaseDate
        self.trackViewUrl = URL(string: trackViewUrl)
        self.trackViewUrl = URL(string: trackViewUrl)
        self.artwork =  URL(string: artwork)
        self.price = price
        self.genres = genres
        self.description = description
        self.primaryGenre = primaryGenre
        
    }
}













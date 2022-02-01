//
//  Media.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/11/21.
//

import Foundation
struct Media
{
    var wrapper: String?
    var name: String?
    var artistName: String?
    var collectName: String?
    var iTunesUrl: URL?
    var artwork: URL?
    var collectPrice: Double?
    var trackPrice: Double?
    var primaryGenre: String?
    var genres: [String]?
    var descript: String?
    var kind: String?
    var shortDescription: String?

    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let name = "artistName"
        static let artistName = "artistName"
        static let collectName = "collectionName"
        static let iTunesUrl = "collectionViewUrl"
        static let artwork = "artworkUrl60"
        static let collectPrice = "collectionPrice"
        static let trackPrice = "trackPrice"
        static let primaryGenre = "primaryGenreName"
        static let genres = "genres"
        static let descript = "description"
        static let kind = "kind"
        static let shortDescription = "shortDescription"
    }
    
    init?(dictionary: [String : Any])
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String ?? "" as String?,
            let name = dictionary[APIKeys.name] as? String ?? "" as String?,
            let artistName = dictionary[APIKeys.artistName] as? String ?? "" as String?,
            let collectName = dictionary[APIKeys.collectName] as? String ?? "" as String?,
            let iTunesUrl = dictionary[APIKeys.iTunesUrl] as? String,
            let artwork = dictionary[APIKeys.artwork] as? String,
            let collectPrice = dictionary[APIKeys.collectPrice] ?? 0.00 as Double?,
            let trackPrice = dictionary[APIKeys.trackPrice] ?? 0.00 as Double?,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String ?? "" as String?,
            let genres = dictionary[APIKeys.genres] as? [String] ?? [] as [String]?,
            let descript = dictionary[APIKeys.descript] as? String ?? "" as String?,
            let kind = dictionary[APIKeys.kind] as? String ?? "" as String?,
            let shortDescription = dictionary[APIKeys.shortDescription] as? String ?? "" as String?
        else {
            return nil
        }
        
        self.wrapper = wrapper
        self.name = name
        self.artistName = artistName
        self.collectName = collectName
        self.iTunesUrl = URL(string: iTunesUrl)
        self.artwork =  URL(string: artwork)
        self.collectPrice = collectPrice as? Double
        self.trackPrice = trackPrice as? Double
        self.primaryGenre = primaryGenre
        self.genres = genres
        self.descript = descript
        self.kind = kind
        self.shortDescription = shortDescription
    }
}











//
//  Television.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/21/21.
//

import Foundation

struct Television
{
    var wrapper: String?
    var kind: String?
    var artistName: String?
    var collectName: String?
    var collectionViewUrl: URL?
    var artwork: URL?
    var collectPrice: Double?
    var trackPrice: Double?
    var primaryGenre: String?
    var description: String?
    var shortDescription: String?

    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let artistName = "artistName"
        static let collectName = "collectionName"
        static let collectionViewUrl = "collectionViewUrl"
        static let artwork = "artworkUrl60"
        static let collectPrice = "collectionPrice"
        static let trackPrice = "trackPrice"
        static let primaryGenre = "primaryGenreName"
        static let description = "longDescription"
        static let kind = "kind"
        static let shortDescription = "shortDescription"
    }
    
    init?(dictionary: Dictionary<String, Any>)
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String ?? "" as String?,
            let artistName = dictionary[APIKeys.artistName] as? String ?? "" as String?,
            let collectName = dictionary[APIKeys.collectName] as? String ?? "" as String?,
            let collectionViewUrl = dictionary[APIKeys.collectionViewUrl] as? String,
            let artwork = dictionary[APIKeys.artwork] as? String,
            let collectPrice = dictionary[APIKeys.collectPrice] ?? 0.00 as Double?,
            let trackPrice = dictionary[APIKeys.trackPrice] ?? 0.00 as Double?,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String ?? "" as String?,
            let description = dictionary[APIKeys.description] as? String ?? "" as String?,
            let kind = dictionary[APIKeys.kind] as? String ?? "" as String?,
            let shortDescription = dictionary[APIKeys.shortDescription] as? String ?? "" as String?
        else {
            return nil
        }
        
        self.wrapper = wrapper
        self.artistName = artistName
        self.collectName = collectName
        self.collectionViewUrl = URL(string: collectionViewUrl)
        self.artwork =  URL(string: artwork)
        self.collectPrice = collectPrice as? Double
        self.trackPrice = trackPrice as? Double
        self.primaryGenre = primaryGenre
        self.description = description
        self.kind = kind
        self.shortDescription = shortDescription
    }
}

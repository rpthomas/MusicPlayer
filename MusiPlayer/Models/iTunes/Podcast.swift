//
//  Podcast.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/19/21.
//

import Foundation

struct Podcast
{
    var wrapper: String?
    var artistName: String?
    var collectName: String?
    var trackName: String?
    var trackViewUrl: URL?
    var collectionViewUrl: URL?
    var artwork: URL?
    var collectPrice: Double?
    var trackPrice: Double?
    var primaryGenre: String?
    var genres: [String]?
    var kind: String?


    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let artistName = "artistName"
        static let collectName = "collectionName"
        static let trackName = "trackName"
        static let trackViewUrl = "trackViewUrl"
        static let collectionViewUrl = "collectionViewUrl"
        static let artwork = "artworkUrl60"
        static let collectPrice = "collectionPrice"
        static let trackPrice = "trackPrice"
        static let primaryGenre = "primaryGenreName"
        static let genres = "genres"
        static let kind = "kind"

    }
    
    init?(dictionary: [String : Any])
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String ?? "" as String?,
            let artistName = dictionary[APIKeys.artistName] as? String ?? "" as String?,
            let collectName = dictionary[APIKeys.collectName] as? String ?? "" as String?,
            let trackViewUrl = dictionary[APIKeys.trackViewUrl] as? String,
            let collectionViewUrl = dictionary[APIKeys.collectionViewUrl] as? String,
            let artwork = dictionary[APIKeys.artwork] as? String,
            let collectPrice = dictionary[APIKeys.collectPrice] ?? 0.00 as Double?,
            let trackPrice = dictionary[APIKeys.trackPrice] ?? 0.00 as Double?,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String ?? "" as String?,
            let genres = dictionary[APIKeys.genres] as? [String] ,
            let kind = dictionary[APIKeys.kind] as? String ?? "" as String?
        else {
            return nil
        }
        
        self.wrapper = wrapper
        self.artistName = artistName
        self.collectName = collectName
        self.trackViewUrl = URL(string: trackViewUrl)
        self.collectionViewUrl = URL(string: collectionViewUrl)
        self.artwork =  URL(string: artwork)
        self.collectPrice = collectPrice as? Double
        self.trackPrice = trackPrice as? Double
        self.primaryGenre = primaryGenre
        self.genres = genres
        print(genres)
        self.kind = kind
    }
}

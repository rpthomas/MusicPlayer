//
//  MusicVideo.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/17/21.
//

import Foundation

struct MusicVideo
{
    var wrapper: String?
    var kind: String?
    var artistName: String?
    var trackName: String?
    var collectName: String?
    var collectionViewUrl: URL?
    var artistViewUrl: URL?
    var artwork: URL?
    var trackPrice: Double?
    var primaryGenre: String?
   
    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let kind = "kind"
        static let artistName = "artistName"
        static let trackName = "trackName"
        static let collectName = "collectionName"
        static let collectionViewUrl = "collectionViewUrl"
        static let artistViewUrl = "artistViewUrl"
        static let artwork = "artworkUrl60"
        static let trackPrice = "trackPrice"
        static let primaryGenre = "primaryGenreName"
        
    }
    
    init?(dictionary: [String : Any])
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String ?? "" as String?,
            let kind = dictionary[APIKeys.kind] as? String ?? "" as String?,
            let artistName = dictionary[APIKeys.artistName] as? String ?? "" as String?,
            let trackName = dictionary[APIKeys.trackName] as? String ?? "" as String?,
            let collectName = dictionary[APIKeys.collectName] as? String ?? "" as String?,
            let artistViewUrl = dictionary[APIKeys.artistViewUrl] as? String ?? "" as String?,
            let collectionViewUrl = dictionary[APIKeys.collectionViewUrl] as? String ?? "" as String?,
            let artwork = dictionary[APIKeys.artwork] as? String ?? "" as String?,
            let trackPrice = dictionary[APIKeys.trackPrice] as? Double ?? 0.00 as Double?,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String ?? "" as String?
            else {
            return nil
        }
        
        self.wrapper = wrapper
        self.kind = kind
        self.artistName = artistName
        self.trackName = trackName
        self.collectName = collectName
        self.artistViewUrl = URL(string: artistViewUrl)
        self.collectionViewUrl = URL(string: collectionViewUrl)
        self.artwork =  URL(string: artwork)
        self.trackPrice = trackPrice
        self.primaryGenre = primaryGenre
        
    }
}













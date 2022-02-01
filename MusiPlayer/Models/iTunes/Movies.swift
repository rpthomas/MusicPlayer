//
//  Movies.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/12/21.
//

import Foundation
struct Movies
{
    var wrapper: String?
    var kind: String?
    var artistType: String?
    var name: String?
    var artistName: String?
    var trackName: String?
    var collectName: String?
    var iTunesUrl: URL?
    var artistLinkUrl: URL?
    var trackViewUrl: URL?
    var artwork: URL?
    var collectPrice: Double?
    var trackPrice: Double?
    var primaryGenre: String?
    var descript: String?
    var shortDescript: String?

    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let artistType = "artistType"
        static let kind = "kind"
        static let name = "artistName"
        static let artistName = "artistName"
        static let trackName = "trackName"
        static let collectName = "collectionName"
        static let iTunesUrl = "collectionViewUrl"
        static let artistLinkUrl = "artistLinkUrl"
        static let trackViewUrl = "trackViewUrl"
        static let artwork = "artworkUrl60"
        static let collectPrice = "collectionPrice"
        static let trackPrice = "trackPrice"
        static let primaryGenre = "primaryGenreName"
        static let descript = "longDescription"
        static let shortDescript = "shortDescription"
    }
    
    init?(dictionary: [String : Any])
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String ?? "" as String?,
            let artistType = dictionary[APIKeys.artistType] as? String ?? "" as String?,
            let kind = dictionary[APIKeys.kind] as? String ?? "" as String?,
            let name = dictionary[APIKeys.name] as? String ?? "" as String?,
            let artistName = dictionary[APIKeys.artistName] as? String ?? "" as String?,
            let trackName = dictionary[APIKeys.trackName] as? String ?? "" as String?,
            let collectName = dictionary[APIKeys.collectName] as? String ?? "" as String?,
            let iTunesUrl = dictionary[APIKeys.iTunesUrl] as? String ?? "" as String?,
            let artistLinkUrl = dictionary[APIKeys.artistLinkUrl] as? String ?? "" as String?,
            let trackViewUrl = dictionary[APIKeys.trackViewUrl] as? String ?? "" as String?,
            let artwork = dictionary[APIKeys.artwork] as? String ?? "" as String?,
            let collectPrice = dictionary[APIKeys.collectPrice] as? Double ?? 0.00 as Double?,
            let trackPrice = dictionary[APIKeys.trackPrice] as? Double ?? 0.00 as Double?,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String ?? "" as String?,
            let descript = dictionary[APIKeys.descript] as? String ?? "" as String?,
            let shortDescript = dictionary[APIKeys.shortDescript] as? String ?? "" as String? else {
            return nil
        }
        
        self.wrapper = wrapper
        self.artistType = artistType
        self.kind = kind
        self.name = name
        self.artistName = artistName
        self.trackName = trackName
        self.collectName = collectName
        self.iTunesUrl = URL(string: iTunesUrl)
        self.artistLinkUrl = URL(string: artistLinkUrl)
        self.trackViewUrl = URL(string: trackViewUrl)
        self.artwork =  URL(string: artwork)
        self.collectPrice = collectPrice
        self.trackPrice = trackPrice
        self.primaryGenre = primaryGenre
        self.descript = descript
        self.shortDescript = shortDescript
    }
}























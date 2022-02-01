//
//  AudioBook.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/9/21.
//

import Foundation

struct AudioBook
{
    var wrapper: String?
    var name: String?
    var collectName: String
    var iTunesUrl: URL?
    var artwork: URL?
    var collectPrice: Double
    var primaryGenre: String
    var descript: String

    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let name = "artistName"
        static let collectName = "collectionName"
        static let iTunesUrl = "collectionViewUrl"
        static let artwork = "artworkUrl60"
        static let collectPrice = "collectionPrice"
        static let primaryGenre = "primaryGenreName"
        static let descript = "description"
    }
    
    init?(dictionary: [String : Any])
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String,
            let name = dictionary[APIKeys.name] as? String,
            let collectName = dictionary[APIKeys.collectName] as? String,
            let iTunesUrl = dictionary[APIKeys.iTunesUrl] as? String,
            let artwork = dictionary[APIKeys.artwork] as? String,
            let collectPrice = dictionary[APIKeys.collectPrice] as? Double,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String,
            let descript = dictionary[APIKeys.descript] as? String else {
            return nil
        }
        
        self.wrapper = wrapper
        self.name = name
        self.collectName = collectName
        self.iTunesUrl = URL(string: iTunesUrl)
        self.artwork =  URL(string: artwork)
        self.collectPrice = collectPrice
        self.primaryGenre = primaryGenre
        self.descript = descript
    }
}























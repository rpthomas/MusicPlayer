//
//  Song.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/9/21.
//

import Foundation
struct Song {
    var playParams: [String: Any]?
    var name: String?
    var artistName: String?
    var artwork: [String: Any]?
    var url: URL?
    var composerName: String?
    var albumName: String?
    var previews: [String]?
    var genreNames: [String]?
    var nextPage: String

    private struct APIKeys {
        static let playParams = "playParams"
        static let name = "name"
        static let artistName = "artistName"
        static let artwork = "artwork"
        static let url = "url"
        static let composerName = "composerName"
        static let albumName = "albumName"
        static let previews = "previews"
        static let genreNames = "genreNames"

    }
 
    init?(dictionary: [String : Any]?) {
        
        
        guard let playParams = dictionary?[APIKeys.playParams] as? [String: Any]? as? [String : Any],
              let name = dictionary?[APIKeys.name] as? String ?? "" as String?,
              let artwork = dictionary?[APIKeys.artwork] as? [String: Any]? as? [String : Any],
              let artistName = dictionary?[APIKeys.artistName] as? String ?? "" as String?,
              let url = dictionary?[APIKeys.url] as? String ?? "" as String?,
              let composerName = dictionary?[APIKeys.composerName] as? String ?? "" as String?,
              let albumName = dictionary?[APIKeys.albumName] as? String ?? "" as String?,
              let previews = dictionary?[APIKeys.previews]  as? [String] ?? [] as [String]?,
              let genreNames = dictionary?[APIKeys.genreNames] as? [String]

        else {
            return nil

    }
        
        self.playParams = playParams
        self.name = name
        self.artwork = artwork
        self.artistName = artistName
        self.url = URL(string: url)
        self.composerName =  composerName
        self.albumName = albumName
        self.previews = previews
        self.genreNames = genreNames
        self.nextPage = ""
        
    }
}

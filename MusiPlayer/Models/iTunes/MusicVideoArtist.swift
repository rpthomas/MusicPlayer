//
//  MusicVideoArtist.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/18/21.
//

import Foundation

struct MusicVideoArtist
{
    var wrapper: String?
    var artistName: String?
    var artistType: String?
    var artistLinkUrl: URL?
    var primaryGenre: String?
   
    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let artistName = "artistName"
        static let artistType = "artistType"
        static let artistLinkUrl = "artistLinkUrl"
        static let primaryGenre = "primaryGenreName"
        
    }
    
    init?(dictionary: [String : Any])
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String ?? "" as String?,
            let artistName = dictionary[APIKeys.artistName] as? String ?? "" as String?,
            let artistType = dictionary[APIKeys.artistType] as? String ?? "" as String?,
            let artistLinkUrl = dictionary[APIKeys.artistLinkUrl] as? String ?? "" as String?,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String ?? "" as String?
            else {
            return nil
        }
        
        self.wrapper = wrapper
        self.artistName = artistName
        self.artistType = artistType
        self.artistLinkUrl = URL(string: artistLinkUrl)
        self.primaryGenre = primaryGenre
        
    }
}













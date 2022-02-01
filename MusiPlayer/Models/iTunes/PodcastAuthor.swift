//
//  PodcastAuthor.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/19/21.
//

import Foundation

struct PodcastAuthor
{
    var wrapper: String?
    var artistType: String?
    var artistName: String?
    var artistLinkUrl: URL?
    var primaryGenre: String?


    
    private struct APIKeys {
        static let wrapper = "wrapperType"
        static let artistType = "artistType"
        static let artistName = "artistName"
        static let artistLinkUrl = "artistLinkUrl"
        static let primaryGenre = "primaryGenreName"
    }
    
    init?(dictionary: [String : Any])
    {
        guard let wrapper = dictionary[APIKeys.wrapper] as? String ?? "" as String?,
            let artistType = dictionary[APIKeys.artistType] as? String ?? "" as String?,
            let artistName = dictionary[APIKeys.artistName] as? String ?? "" as String?,
            let artistLinkUrl = dictionary[APIKeys.artistLinkUrl] as? String,
            let primaryGenre = dictionary[APIKeys.primaryGenre] as? String ?? "" as String?
                   else {
            return nil
        }
        
        self.wrapper = wrapper
        self.artistType = artistType
        self.artistName = artistName
        self.artistLinkUrl = URL(string: artistLinkUrl)
        self.primaryGenre = primaryGenre

    }
}

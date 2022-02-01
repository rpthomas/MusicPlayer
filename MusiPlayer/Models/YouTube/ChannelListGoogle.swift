//
//  ChannelListGoogle.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/25/21.
//

import Foundation

struct ChannelListGoogle
{
    var items: [Any]?
    var snippet: [String: [String : Any]]?
    var id: String?
   
    private struct APIKeys {
        static let items = "items"
        static let snippet = "snippet"
        static let id = "id"
        
    }
    
    init?(dictionary: [String : Any])
    {
        guard let items = dictionary[APIKeys.items] as? [Any] ?? [] as [Any]?,
              let snippet = dictionary[APIKeys.snippet] as? [String :[String : Any]],
              let id = dictionary[APIKeys.id] as? String
        else {
            return nil
        }
        
        self.items = items
        self.snippet = snippet
        self.id = id
        
    }
}

struct PlaylistsGoogle
{
    var nextPageToken: String?
    var prevPageToken: String?
    var items: [Any]?
    var snippet: [String : Any]?
    //var thumbnails: [String : Any]?
    var id: String?
   
    private struct APIKeys {
        static let items = "items"
        static let snippet = "snippet"
        //static let thumbnails = "thumbnails"
        static let id = "id"
        static let nextPageToken = "nextPageToken"
        static let prevPageToken = "prevPageToken"
        
    }
    
    init?(dictionary: [String : Any], nextPageToken : String?, prevPageToken : String?)
    {
        print(dictionary[APIKeys.items] as? String as Any)
        print(dictionary[APIKeys.snippet] as? [String:Any] as Any)
        //print(dictionary[APIKeys.thumbnails] as? [String:Any] as Any)
        print(dictionary[APIKeys.id] as? String as Any)
        guard let items = dictionary[APIKeys.items] as? [Any] ?? [] as [Any]?,
              let snippet = dictionary[APIKeys.snippet] as? [String : Any],
              //let thumbnails = dictionary[APIKeys.thumbnails] as? [String : Any],
              let id = dictionary[APIKeys.id] as? String,
              let nextPageToken = nextPageToken ?? "" as String?,
              let prevPageToken = prevPageToken ?? "" as String?

        else {
            return nil
        }
        
        self.items = items
        
        self.snippet = snippet
        //self.thumbnails = thumbnails
        self.id = id
        print(self.id!)
        self.nextPageToken = nextPageToken
        self.prevPageToken = prevPageToken

    }
}




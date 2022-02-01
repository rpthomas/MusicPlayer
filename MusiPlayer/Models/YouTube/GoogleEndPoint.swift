//
//  GoogleEndPoint.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/22/21.
//

//https://www.googleapis.com/youtube/v3/search

//You could also make the requests yourself. Here is an example URL that retrieves the latest videos from a channel:
//https://www.googleapis.com/youtube/v3/search?key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY&part=snippet,id&order=date&maxResults=20

//After that you will receive a JSON with video ids and details, and you can construct your video URL like this:

//To Watch Video
//http://www.youtube.com/watch?v=Q9aD8ahcELk
//http://www.youtube.com/watch?v={video_id_here}

///============================================================

//1.
//Get Channels list by forUserName
//music
//id = UCbms89jPL-VXHeeFfZfi7Ww
//https://www.googleapis.com/youtube/v3/channels?part=snippet,contentDetails,statistics&forUsername=Music&key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY



//2.
//Get Playlists by Channel ID:
//https://www.googleapis.com/youtube/v3/playlists?part=snippet,contentDetails&channelId=UCbms89jPL-VXHeeFfZfi7Ww&maxResults=50&key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY

//Get Playlists by Channel ID with pageToken:

//https://www.googleapis.com/youtube/v3/playlists?part=snippet,contentDetails&channelId=UCbms89jPL-VXHeeFfZfi7Ww&maxResults=50&maxResults=50&key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY&pageToken=CDIQAA

//3.
//Get PlaylistItems list by PlayListId
//https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PL4h7dUOICcHXgUoEjsQZPmCvZAjpfug2t&key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY

//4.
//To get videos :
//Get videos list by video id:
//https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&id=s8UQbzvSVy8&key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY

//5.
//To Watch Video
//http://www.youtube.com/watch?v=s8UQbzvSVy8
//http://www.youtube.com/watch?v={video_id_here}


//==================================================
//Next, get a list of videos in that playlist:
//https://developers.google.com/youtube/v3/docs/playlistItems/list#try-it
//Just drop in the playlistId!
//GET //https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=UUpRmvjdu3ixew5ahydZ67uA&key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY

//https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=UUpRmvjdu3ixew5ahydZ67uA&key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY



//API Key
//Use this key in your application by passing it with the key=API_KEY parameter.
//AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY


//'https://youtube.googleapis.com/youtube/v3/channels?key=[YOUR_API_KEY]' \
//--header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
//--header 'Accept: application/json' \
//--compressed




//Get channels list by channel id:
//https://www.googleapis.com/youtube/v3/channels/?part=snippet,contentDetails,statistics&id=UCE_M8A5yxnLfW0KghEeajjw&key=

//Get Channel sections:
//https://www.googleapis.com/youtube/v3/channelSections?part=snippet,contentDetails&channelId=UCE_M8A5yxnLfW0KghEeajjw&key=

//UCbms89jPL-VXHeeFfZfi7Ww

//https://www.googleapis.com/youtube/v3/channels/?part=snippet,contentDetails,statistics&id=UCE_M8A5yxnLfW0KghEeajjw&key=AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY



//Get Playlists by Channel ID with pageToken:
//https://www.googleapis.com/youtube/v3/playlists?part=snippet,contentDetails&channelId=UCq-Fj5jknLsUf-MWSy4_brA&maxResults=50&key=&pageToken=CDIQAA

//To get PlaylistItems :
//Get PlaylistItems list by PlayListId:
//https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails&maxResults=25&playlistId=PLHFlHpPjgk70Yv3kxQvkDEO5n5tMQia5I&key=

//To get videos :
//Get videos list by video id:
//https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&id=YxLCwfA1cLw&key=

//Get videos list by multiple videos id:
//https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&id=YxLCwfA1cLw,Qgy6LaO3SB0,7yPJXGO2Dcw&key=

//Get comments list
//Get Comment list by video ID:
//https://www.googleapis.com/youtube/v3/commentThreads?part=snippet,replies&videoId=el****kQak&key=A**********k

//Get Comment list by channel ID:
//https://www.googleapis.com/youtube/v3/commentThreads?part=snippet,replies&channelId=U*****Q&key=AI********k

//Get Comment list by allThreadsRelatedToChannelId:
// https://www.googleapis.com/youtube/v3/commentThreads?part=snippet,replies&allThreadsRelatedToChannelId=UC*****ntcQ&key=AI*****k

//Here all api's are Get approach.
//Based on channel id we con't get all videos directly, that's the important point here.
//For integration https://developers.google.com/youtube/v3/quickstart/ios?ver=swift



import Foundation

enum GoogleEndpoint
{
    //Get Channels list by forUserName
    case channels(forUsername: String)
    
    var request: URLRequest {
        var components = URLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryComponents
        print(components)
        
        let url = components.url!
        return URLRequest(url: url)
    }
    
    private var baseURL: String {
        return "https://www.googleapis.com/"
    }
    
   
    
    private var accessKey: String {
        return "AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY"
    }
    
    private var path: String {
        switch self {
        case .channels: return "/youtube/v3/channels"
        }
    }
    
    private struct ParameterKeys {
        static let part = "part"
        static let forUsername = "forUsername"
        static let key = "key"
        static let maxResults = "maxResults"
    }
    
    private struct DefaultValues {
        static let part = "snippet,contentDetails,statistics"
        static let AccessKey = "AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY"
        static let maxResults = "50"
    }
    
   
    private var parameters: [String : Any] {
        switch self {
        case .channels(let forUsername):
            let parameters: [String : Any] = [
                ParameterKeys.part : DefaultValues.part,
                ParameterKeys.forUsername : forUsername,
                ParameterKeys.key : DefaultValues.AccessKey,
                ParameterKeys.maxResults : DefaultValues.maxResults
            ]
            
            return parameters
        }
    }
    
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
    
    //Need to append "contentDetails" and "statistics" to end of components
}



enum GoogleEndpointB
{
    //Get Channels list by forUserName
    case playlists(channelId: String)
    
    case playlistsNext(channelId: String, withNextPage: String)
    
    //Get PlaylistItems list by PlayListId
    case playlistsItems(playListID: String)
    
    case playlistsItemsNext(playListID: String, withNextPage: String)


    
    var request: URLRequest {
        var components = URLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryComponents
        print(components)
        
        let url = components.url!
        return URLRequest(url: url)
    }
    
    private var baseURL: String {
        return "https://www.googleapis.com/"
    }
    
   
    
    private var accessKey: String {
        return "AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY"
    }
    
    private var path: String {
        switch self {
        case .playlists: return "/youtube/v3/playlists"
        case .playlistsNext: return "/youtube/v3/playlists"
        case .playlistsItems: return "/youtube/v3/playlistItems"
        case .playlistsItemsNext: return "/youtube/v3/playlistItems"

        }
    }
    
    private struct ParameterKeys {
        static let part = "part"
        static let channelId = "channelId"
        static let playlistId = "playlistId"
        static let key = "key"
        static let maxResults = "maxResults"
        static let pageToken = "pageToken"
    }
    
    private struct DefaultValues {
        static let part = "snippet,contentDetails"
        static let AccessKey = "AIzaSyA-CPGGfGM1amjspULMezMglYNEyFJYmIY"
        static let maxResults = "50"

    }
    
    private struct DefaultValuesItems {
        static let part = "snippet"
    }
    
   
    private var parameters: [String : Any] {
        switch self {
        case .playlists(let channelId):
            let parameters: [String : Any] = [
                ParameterKeys.part : DefaultValues.part,
                ParameterKeys.channelId : channelId,
                ParameterKeys.key : DefaultValues.AccessKey,
                ParameterKeys.maxResults : DefaultValues.maxResults

            ]
            
            return parameters
        case .playlistsNext(let channelId, let withNextPage):
            let parameters: [String : Any] = [
                ParameterKeys.part : DefaultValues.part,
                ParameterKeys.channelId : channelId,
                ParameterKeys.key : DefaultValues.AccessKey,
                ParameterKeys.pageToken: withNextPage,
                ParameterKeys.maxResults : DefaultValues.maxResults

            ]
            
            return parameters

        case .playlistsItems(let playlistId):
            let parameters: [String : Any] = [
                ParameterKeys.part : DefaultValuesItems.part,
                ParameterKeys.playlistId : playlistId,
                ParameterKeys.key : DefaultValues.AccessKey,
                ParameterKeys.maxResults : DefaultValues.maxResults

            ]
            
            return parameters
        case .playlistsItemsNext(let playlistId, let withNextPage):
            let parameters: [String : Any] = [
                ParameterKeys.part : DefaultValuesItems.part,
                ParameterKeys.playlistId : playlistId,
                ParameterKeys.key : DefaultValues.AccessKey,
                ParameterKeys.pageToken: withNextPage,
                ParameterKeys.maxResults : DefaultValues.maxResults

            ]
            
            return parameters
        }
    }
    
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
    
    //Need to append "contentDetails" and "statistics" to end of components
}









//
//  Definitions.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/1/21.
//

import Foundation

let pickerOneArray = ["Audio Book", "Media", "Movie", "Music", "Music Video", "Podcast", "Software", "Television"]

var countriesDict = ["ae": "United Arab Emirates",
                     "ag": "Antigua and Barbuda",
                     "ai": "Anguilla",
                     "al": "Albania",
                     "am": "Armenia",
                     "ao": "Angola",
                     "ar": "Argentina",
                     "at": "Austria",
                     "au": "Australia",
                     "az": "Azerbaijan",
                     "bb": "Barbados",
                     "be": "Belgium",
                     "bf": "Burkina-Faso",
                     "bg": "Bulgaria",
                     "bh": "Bahrain",
                     "bj": "Benin",
                     "bm": "Bermuda",
                     "bn": "Brunei Darussalam",
                     "bo": "Bolivia",
                     "br": "Brazil",
                     "bs": "Bahamas",
                     "bt": "Bhutan",
                     "bw": "Botswana",
                     "by": "Belarus",
                     "bz": "Belize",
                     "ca": "Canada",
                     "cg": "Democratic Republic of the Congo",
                     "ch": "Switzerland",
                     "cl": "Chile",
                     "cn": "China",
                     "co": "Colombia",
                     "cr": "Costa Rica",
                     "cv": "Cape Verde",
                     "cy": "Cyprus",
                     "cz": "Czech Republic",
                     "de": "Germany",
                     "dk": "Denmark",
                     "dm": "Dominica",
                     "do": "Dominican Republic",
                     "dz": "Algeria",
                     "ec": "Ecuador",
                     "ee": "Estonia",
                     "eg": "Egypt",
                     "es": "Spain",
                     "fi": "Finland",
                     "fj": "Fiji",
                     "fm": "Federated States of Micronesia",
                     "fr": "France",
                     "gb": "Great Britain",
                     "gd": "Grenada",
                     "gh": "Ghana",
                     "gm": "Gambia",
                     "gr": "Greece",
                     "gt": "Guatemala",
                     "gw": "Guinea Bissau",
                     "gy": "Guyana",
                     "hk": "Hong Kong",
                     "hn": "Honduras",
                     "hr": "Croatia",
                     "hu": "Hungaria",
                     "id": "Indonesia",
                     "ie": "Ireland",
                     "il": "Israel",
                     "in": "India",
                     "is": "Iceland",
                     "it": "Italy",
                     "jm": "Jamaica",
                     "jo": "Jordan",
                     "jp": "Japan",
                     "ke": "Kenya",
                     "kg": "Krygyzstan",
                     "kh": "Cambodia",
                     "kn": "Saint Kitts and Nevis",
                     "kr": "South Korea",
                     "kw": "Kuwait",
                     "ky": "Cayman Islands",
                     "kz": "Kazakhstan",
                     "la": "Laos",
                     "lb": "Lebanon",
                     "lc": "Saint Lucia",
                     "lk": "Sri Lanka",
                     "lr": "Liberia",
                     "lt": "Lithuania",
                     "lu": "Luxembourg",
                     "lv": "Latvia",
                     "md": "Moldova",
                     "mg": "Madagascar",
                     "mk": "Macedonia",
                     "ml": "Mali",
                     "mn": "Mongolia",
                     "mo": "Macau",
                     "mr": "Mauritania",
                     "ms": "Montserrat",
                     "mt": "Malta",
                     "mu": "Mauritius",
                     "mw": "Malawi",
                     "mx": "Mexico",
                     "my": "Malaysia",
                     "mz": "Mozambique",
                     "na": "Namibia",
                     "ne": "Niger",
                     "ng": "Nigeria",
                     "ni": "Nicaragua",
                     "nl": "Netherlands",
                     "np": "Nepal",
                     "no": "Norway",
                     "nz": "New Zealand",
                     "om": "Oman",
                     "pa": "Panama",
                     "pe": "Peru",
                     "pg": "Papua New Guinea",
                     "ph": "Philippines",
                     "pk": "Pakistan",
                     "pl": "Poland",
                     "pt": "Portugal",
                     "pw": "Palau",
                     "py": "Paraguay",
                     "qa": "Qatar",
                     "ro": "Romania",
                     "ru": "Russia",
                     "sa": "Saudi Arabia",
                     "sb": "Soloman Islands",
                     "sc": "Seychelles",
                     "se": "Sweden",
                     "sg": "Singapore",
                     "si": "Slovenia",
                     "sk": "Slovakia",
                     "sl": "Sierra Leone",
                     "sn": "Senegal",
                     "sr": "Suriname",
                     "st": "Sao Tome e Principe",
                     "sv": "El Salvador",
                     "sz": "Swaziland",
                     "tc": "Turks and Caicos Islands",
                     "td": "Chad",
                     "th": "Thailand",
                     "tj": "Tajikistan",
                     "tm": "Turkmenistan",
                     "tn": "Tunisia",
                     "tr": "Turkey",
                     "tt": "Republic of Trinidad and Tobago",
                     "tw": "Taiwan",
                     "tz": "Tanzania",
                     "ua": "Ukraine",
                     "ug": "Uganda",
                     "us": "United States of America",
                     "uy": "Uruguay",
                     "uz": "Uzbekistan",
                     "vc": "Saint Vincent and the Grenadines",
                     "ve": "Venezuela",
                     "vg": "British Virgin Islands",
                     "vn": "Vietnam",
                     "ye": "Yemen",
                     "za": "South Africa",
                     "zw": "Zimbabwe"]

//======================
//Audio Book
enum audioBookEnum : CustomStringConvertible, CaseIterable {
    case AudioBookAuthor
    case AudioBook
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .AudioBookAuthor: return "Audio Book Author"
        case .AudioBook: return "Audio Book"
        }
      }
}

let audioBookDict = [audioBookEnum.AudioBookAuthor : "audiobookAuthor", audioBookEnum.AudioBook : "audiobook"]


//======================
//Media -- No Enity

//======================
//Movie

enum movieEnum : CustomStringConvertible, CaseIterable {
    case MovieArtist
    case Movie
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .MovieArtist: return "Movie Artist"
        case .Movie: return "Movie"
        }
      }
}


//======================
//Music

enum musicEnum : CustomStringConvertible, CaseIterable {
    case MusicArtist
    case MusicTrack
    case Album
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .MusicArtist: return "Music Artist"
        case .MusicTrack: return "Music Track"
        case .Album: return "Album"
        }
      }
}





//======================
//Music Video

enum musicVideoEnum : CustomStringConvertible, CaseIterable {
    case MusicVideoArtist
    case MusicVideo
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .MusicVideoArtist: return "Music Video Artist"
        case .MusicVideo: return "Music Video"

        }
      }
}

//======================
//Pod Cast

enum podCastEnum : CustomStringConvertible, CaseIterable {
    case PodCastAuthor
    case PodCast
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .PodCastAuthor: return "Pod Cast Author"
        case .PodCast: return "Podcast"

        }
      }
}

//======================
//Software

enum softwareEnum : CustomStringConvertible, CaseIterable {
    case Software
    case iPhoneSoftware
    case iPadSoftware
    case macSoftware
    case softwareDeveloper
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Software: return "All Mobile"
        case .iPhoneSoftware: return "iPhone Software"
        case .iPadSoftware: return "iPad Software"
        case .macSoftware: return "Mac Software"
        case .softwareDeveloper: return "Software Developer"

        }
      }
}

//======================
//Television

enum televisionEnum : CustomStringConvertible, CaseIterable {
    case tvEpisode
    case tvSeason
        
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .tvEpisode: return "TV Episode"
        case .tvSeason: return "TV Season"
        
        }
      }
}

let enityDict = [audioBookEnum.AudioBookAuthor.description : "audiobook", audioBookEnum.AudioBook.description : "audiobook", movieEnum.MovieArtist.description : "movieArtist", movieEnum.Movie.description : "movie", musicEnum.MusicArtist.description : "musicArtist", musicEnum.MusicTrack.description : "musicTrack", musicEnum.Album.description : "album", musicVideoEnum.MusicVideoArtist.description : "musicArtist", musicVideoEnum.MusicVideo.description : "musicVideo", podCastEnum.PodCastAuthor.description : "podcastAuthor", podCastEnum.PodCast.description : "podcast", softwareEnum.Software.description : "software,iPadSoftware,macSoftware", softwareEnum.iPadSoftware.description : "iPadSoftware", softwareEnum.iPhoneSoftware.description : "software", softwareEnum.macSoftware.description : "macSoftware", televisionEnum.tvEpisode.description : "tvEpisode", televisionEnum.tvSeason.description : "tvSeason", softwareEnum.softwareDeveloper.description : "software"  ]

let mediaDict = ["Audio Book" : "audiobook", "Movie" : "movie",  "Music" : "music",  "Music Video" : "musicVideo", "Podcast" : "podcast", "Software" : "software","Television" : "tvShow" ]

let attributesDict = ["Audio Book Author" : "authorTerm", "Audio Book" : "titleTerm", "Movie Artist" : "movieArtistTerm", "Movie" : "movieArtistTerm", "Music Artist" : "artistTerm", "Music Track" : "songTerm", "Album" : "albumTerm", "Music Video" : "songTerm", "Music Video Artist" : "artistTerm", "Pod Cast Author" : "authorTerm", "Podcast" : "titleTerm", "TV Episode" : "tvEpisodeTerm", "TV Season" : "tvSeasonTerm", "Software Developer" : "softwareDeveloper" ]

enum UTubeSubscribers : Int, CaseIterable {
    case Music = 0
    case PewDiePie = 1
    case Sporte = 2
    case WWE = 3
    case MrBeast = 4
    case Movieclips = 5
    case EminemMusic = 6
    case BangtanTV = 7
    case JuegaGerman = 8
    case HolaSoyGerman = 9
    case whinderssonnunes = 10
    case Fernanfloo = 11
    case elrubiusOMG = 12
    case TheEllenShow = 13
    case YRF = 14
    static var count: Int { return UTubeSubscribers.YRF.rawValue + 1 }


    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Music: return "Music"
        case .PewDiePie: return "PewDiePie"
        case .Sporte: return "Sporte"
        case .WWE: return "WWE"
        case .MrBeast: return "MrBeast"
        case .Movieclips: return "Movieclips"
        case .EminemMusic: return "EminemMusic"
        case .BangtanTV: return "BangtanTV"
        case .JuegaGerman: return "JuegaGerman"
        case .HolaSoyGerman: return "HolaSoyGerman"
        case .whinderssonnunes: return "whinderssonnunes"
        case .Fernanfloo: return "Fernanfloo"
        case .elrubiusOMG: return "elrubiusOMG"
        case .TheEllenShow: return "TheEllenShow"
        case .YRF: return "YRF"

        }
      }
}







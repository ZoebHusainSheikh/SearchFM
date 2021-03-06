//
//  SearchModels.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import Foundation

enum SearchType: Int {
    case artist
    case album
    case track
    
    func url(for search: String) -> String {
        switch self {
        case .artist:
            return Constants.artistSearchURL + search
        case .album:
            return Constants.albumSearchURL + search
        case .track:
            return Constants.trackSearchURL + search
        }
    }
}

enum Search
{
    // MARK: Use cases
    
    enum Fetch
    {
        struct Request
        {
            let url: String
            var params : Dictionary<String, Any>?
        }
        struct Response
        {
            let data: Data?
        }
        struct ViewModel
        {
            var results: Results?
        }
    }
}

class SearchResponse: NSObject, Codable {
    var results: Results?
}

extension SearchResponse {
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

class Results: NSObject, Codable {
    var artistMatches: ArtistMatches?
    var albumMatches: AlbumMatches?
    var trackMatches: TrackMatches?
}

extension Results {
    enum CodingKeys: String, CodingKey {
        case artistMatches = "artistmatches"
        case albumMatches = "albummatches"
        case trackMatches = "trackmatches"
    }
}

class ArtistMatches: NSObject, Codable {
    var artists: [Record]?
}

extension ArtistMatches {
    enum CodingKeys: String, CodingKey {
        case artists = "artist"
    }
}

class AlbumMatches: NSObject, Codable {
    var albums: [Record]?
}

extension AlbumMatches {
    enum CodingKeys: String, CodingKey {
        case albums = "album"
    }
}

class TrackMatches: NSObject, Codable {
    var tracks: [Record]?
}

extension TrackMatches {
    enum CodingKeys: String, CodingKey {
        case tracks = "track"
    }
}

class Record: NSObject, Codable {
    var name: String?
    var url: String?
    var images: [[String: String]]?
    
    var displayImageURL: URL? {
        guard let images = self.images, let imageInfo = images.first else { return nil }
        
        if let imagePath = imageInfo["#text"] {
            return URL(string: imagePath)
        }
        
        return nil
    }
}

extension Record {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
        case images = "image"
    }
}

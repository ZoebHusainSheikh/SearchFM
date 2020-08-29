//
//  Constants.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import Foundation

struct Constants {
    static let apiKey = "c68711f5757c83e1eb76b48aab9d3780"
    static let baseUrl: String = "http://ws.audioscrobbler.com/2.0/?api_key=\(apiKey)&format=json&limit=50"
    static let albumSearchURL: String = baseUrl + "&method=album.search&album="
    static let artistSearchURL: String = baseUrl + "&method=artist.search&artist="
    static let trackSearchURL: String = baseUrl + "&method=track.search&track="
}

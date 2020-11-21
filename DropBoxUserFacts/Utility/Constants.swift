//
//  Constants.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import Foundation

struct BaseUrl {
    struct ProductionServer {
        static let baseURL = "https://dl.dropboxusercontent.com"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
enum CellReuseIdentifier: String {
    case reuseIdentifire = "ListCollectionViewCell"
}

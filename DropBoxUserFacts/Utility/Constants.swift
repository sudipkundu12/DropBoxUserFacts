//
//  Constants.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import Foundation
import UIKit

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
    case reuseIdentifire = "FactsListTableViewCell"
}
enum NetworkError: String {
    case errorTitle = "Network Error"
    case errorMessage = "Please check your network connection"

}
struct ErrorString {
    static let tableViewError = "Failed to dequeue a FactsListTableViewCell."
    static let imageUrlError = "Failed to dequeue a imageUrl."
    static let jsonResultError = "Failed to dequeue a jsonResult."
    static let rowsModelError = "Failed to dequeue a RowsModel."
    static let initCoderError = "init(coder:) has not been implemented"
}

struct Padding {
    static let leftPadding = 10
    static let rightPadding = -10
    static let topPadding = 10
    static let bottomPadding = 10
    static let defaultPadding = 0
}
struct ContentViewPadding {
    static let leftPadding = 16
    static let rightPadding = -16
    static let topPadding = 10
    static let bottomPadding = -10
}
struct imageViewSize {
    static let height = 50
    static let width = 60
}
struct viewConstants {
    static let cornerRadious = 8
}
extension UIFont {
    class func heavy() -> UIFont {
       return UIFont(name: "Avenir-Heavy", size: 18) ?? UIFont.boldSystemFont(ofSize: 18)
    }
    class func medium() -> UIFont {
       return UIFont(name: "Avenir-Medium", size: 17) ?? UIFont.systemFont(ofSize: 17)
    }
    class func regular() -> UIFont {
      return UIFont(name: "Avenir", size: 15) ?? UIFont.systemFont(ofSize: 15)
    }
    
}


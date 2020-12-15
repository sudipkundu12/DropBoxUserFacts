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
struct ViewPadding {
    static let topPadding = 8
    static let leftPadding = 16
    static let rightPadding = 16
    static let bottomPadding = 8
}
extension UIFont {
    class func heavy(ofSize size: CGFloat) -> UIFont {
       return UIFont(name: "Avenir-Heavy", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    class func medium(ofSize size: CGFloat) -> UIFont {
       return UIFont(name: "Avenir-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func regular(ofSize size: CGFloat) -> UIFont {
      return UIFont(name: "Avenir", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}


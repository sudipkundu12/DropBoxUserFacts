//
//  RowsModel.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import Foundation
import SwiftyJSON

struct RowsModel: Codable {

    private struct SerializationKeys {
        static let title = "title"
        static let description = "description"
        static let imageHref = "imageHref"
        static let imageHeight = "imageHeight"

    }

    // MARK: Properties
    public var title: String = ""
    public var description: String = ""
    public var imageHref: String = ""
    public var imageHeight: Int = 0

    public init(object: Any) {
        self.init(json: JSON(object))
    }

    public init(json: JSON) {
        title = json[SerializationKeys.title].stringValue
        description = json[SerializationKeys.description].stringValue
        imageHref = json[SerializationKeys.imageHref].stringValue
        imageHeight = json[SerializationKeys.imageHeight].intValue

    }
    mutating func set_imageHeight(value: Int = 0) {
        self.imageHeight = value

    }

}

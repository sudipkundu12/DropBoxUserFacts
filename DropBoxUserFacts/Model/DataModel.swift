//
//  DataModel.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import Foundation
import SwiftyJSON

struct DataModel: Codable {

    private struct SerializationKeys {
        static let title = "title"
        static let rows = "rows"
    }
    // MARK: Properties
    public var title: String?
    public var rows: [RowsModel] = []

    public init(object: Any) {
        self.init(json: JSON(object))
    }
    public init(json: JSON) {
        title = json[SerializationKeys.title].string
        if let items = json[SerializationKeys.rows].array { rows = items.map { RowsModel(json: $0) } }
    }

}

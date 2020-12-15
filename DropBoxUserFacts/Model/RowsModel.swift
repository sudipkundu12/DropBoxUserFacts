//
//  RowsModel.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import Foundation

struct RowsModel: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
    var imageHeight = 100
    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
    }
    mutating func set_imageHeight(value: Int = 100) {
        self.imageHeight = value

    }
}


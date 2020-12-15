//
//  TestUtility.swift
//  DropBoxUserFactsTests
//
//  Created by sudip kundu on 15/12/20.
//

import Foundation

class TestUtility {


    static func readJSONFromFile<T: Decodable>(fileName: String, type: T.Type) -> T? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
  }
}

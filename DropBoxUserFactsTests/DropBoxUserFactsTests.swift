//
//  DropBoxUserFactsTests.swift
//  DropBoxUserFactsTests
//
//  Created by sudip kundu on 20/11/20.
//

import XCTest
import Alamofire

@testable import DropBoxUserFacts

class DropBoxUserFactsTests: XCTestCase {

    func testforAboutApi() {
        let expection = expectation(description: "Alamofire")
        AF.request(APIRouter.facts).responseString { (response) in
            XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")

            XCTAssertNotNil(response, "No response")
            XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
            expection.fulfill()
        }
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    // MARK: Check for Inserting model Data
    func testForModelDataUsingApi() {
        let expection = expectation(description: "Alamofire")
        APIClient().apiGet(serviceName: APIRouter.facts) { (json: Data?, error: NSError?) in
            XCTAssertNil(error, "Whoops, error \(error!.localizedDescription)")
            guard let jsonResult = json else {
                return
            }
            let jsonDecoder = JSONDecoder()
            let aboutData = try? jsonDecoder.decode(DataModel.self, from: jsonResult)
            

            XCTAssertNotNil(aboutData)
            XCTAssertEqual(aboutData?.title, "About Canada")
            for index in 0..<(aboutData?.rows?.count)! {
                if ((aboutData?.rows![index].title?.isEmpty) != nil) {
                    XCTAssertTrue(((aboutData?.rows?[index].title?.isEmpty) != nil), "Title Not Found")
                } else {
                    XCTAssertFalse(((aboutData?.rows?[index].title?.isEmpty) != nil), "Title is present")
                }
                if ((aboutData?.rows?[index].description?.isEmpty) != nil) {
                    XCTAssertTrue(((aboutData?.rows?[index].description?.isEmpty) != nil), "Description Not Found")
                } else {
                    XCTAssertFalse(((aboutData?.rows?[index].description?.isEmpty) != nil), "description Data is present")
                }
                if ((aboutData?.rows?[index].imageHref?.isEmpty) != nil) {
                    XCTAssertTrue(((aboutData?.rows?[index].imageHref?.isEmpty) != nil), "Image URL Not Found")
                } else {
                    XCTAssertFalse(((aboutData?.rows?[index].imageHref?.isEmpty) != nil), "Image URL is present")
                }
            }
            expection.fulfill()
        }
        waitForExpectations(timeout: 60.0, handler: nil)
    }

    // MARK: Check Image Response
    func testforNotGetingImageData() {
        // This URL Not getting image Data
        let expection = expectation(description: "Alamofire")
        AF.request("http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png", method: .get).responseImage { response in
            XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
            XCTAssertNotNil(response, "No response")
            XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
            expection.fulfill()
        }
        waitForExpectations(timeout: 120.0, handler: nil)
    }
    func testforimageURL() {
        let expection = expectation(description: "Alamofire")
        AF.request("http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg", method: .get).responseImage { response in
            XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")

            XCTAssertNotNil(response, "No response")
            XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
            expection.fulfill()

        }
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    // MARK: Test With Mock Data
    func test_ParsingValidJSON_ReturnsDataModel() {
        
        let aboutData = TestUtility.readJSONFromFile(fileName: "FactsMockData", type: DataModel.self)
        XCTAssertNotNil(aboutData)
        XCTAssertEqual(aboutData?.title, "About Canada")
        XCTAssertEqual(aboutData?.rows?[0].title, "Beavers")
        XCTAssertNotNil(aboutData?.title)
        XCTAssertTrue(((aboutData?.rows?[2].title?.isEmpty) != nil))
        XCTAssertTrue(((aboutData?.rows?[2].title?.isEmpty) != nil))
        XCTAssertTrue(((aboutData?.rows?[2].imageHref?.isEmpty) != nil))

    }

}

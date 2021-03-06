//
//  APIClient.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//
import UIKit
import Alamofire
import AlamofireImage

class APIClient {
    // MARK: Get API Call
    func apiGet(serviceName: APIRouter, completionHandler: @escaping (Data?, NSError?) -> Void) {
        AF.request(serviceName).responseString { (response) in
            switch(response.result) {

            case .success(let value):
                if let dataFromString = value.data(using: .utf8, allowLossyConversion: false) {
                    completionHandler(dataFromString, nil)
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
        }
        /* ... */
    }
    // MARK: ImageURLResponse
    func getImageSizeFromURL(imageUrl: URL, completionHandler: @escaping (UIImage?, NSError?) -> Void) {
        AF.request(imageUrl, method: .get).responseImage { response in
            switch(response.result) {
            case .success(let value):
                    completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
        /* ... */
    }
}

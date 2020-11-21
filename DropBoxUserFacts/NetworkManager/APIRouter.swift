//
//  APIRouter.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case facts
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .facts:
            return .get
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .facts:
            return "/s/2iodh4vg0eortkl/facts.json"
        }
    }
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .facts:
            return nil
        }
    }
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try BaseUrl.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}

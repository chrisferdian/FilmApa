//
//  APIRouter.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 16/12/20.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    
    case genres
    case discovers(genreId: Int, page: Int)
    case reviews(movieId: String, page: Int)
    case videos(movieId: String)
    case credits(movieId: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .genres,
             .discovers,
             .reviews,
             .videos,
             .credits:
            return .get
        }
    }
    // MARK: - Parameters
     var parameters: RequestParams {
        switch self {
        case .genres:
            return.url(["api_key":"a42b168856dcc7d96b4321bee09e82b3"])
        case .discovers(let id, let page):
            return.url(["api_key":"a42b168856dcc7d96b4321bee09e82b3", "with_genres": String(id), "page": String(page)])
        case .reviews( _, let page):
            return.url(["api_key": "a42b168856dcc7d96b4321bee09e82b3", "page": String(page)])
        case .videos:
            return.url(["api_key": "a42b168856dcc7d96b4321bee09e82b3"])
        case .credits:
            return.url(["api_key": "a42b168856dcc7d96b4321bee09e82b3"])
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .genres:
            return "/genre/movie/list"
        case .discovers:
            return "/discover/movie"
        case .reviews(let movieId, _):
            return "/movie/\(movieId)/reviews"
        case .videos(let movieId):
            return "/movie/\(movieId)/videos"
        case.credits(let movieId):
            return "/movie/\(movieId)/credits"
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        switch parameters {
            
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            
        case .url(let params):
                let queryParams = params.map { pair  in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
        }
            return urlRequest
    }
}

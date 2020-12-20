//
//  APIConfiguration.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 16/12/20.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}

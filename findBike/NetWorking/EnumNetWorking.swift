//
//  EnumNetWorking.swift
//  findBike
//
//  Created by Israel on 2/12/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible {

    case login(client_id:String, client_secret:String, grant_type:String)
    case stations(access_token:String)
    case status(access_token:String)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login ,.stations, .status:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .login(let client_id, let client_secret, let grant_type):
            return "oauth/v2/token?client_id="+client_id+"&client_secret=" + client_secret + "&grant_type=" + grant_type
        case .stations:
            return "api/v1/stations.json"
        case .status:
            return "api/v1/stations.json"
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let client_id, let client_secret, let grant_type):
            return [K.APIParameterKey.client_id: client_id, K.APIParameterKey.client_secret: client_secret, K.APIParameterKey.grant_type:grant_type]
        case .stations(let access_token):
            return [K.APIParameterKey.access_token: access_token]
        case .status(let access_token):
             return [K.APIParameterKey.access_token: access_token]
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url = try K.ProductionServer.baseURL.asURL()
        
        //var strURL:String = ""
        var urlRequest:URLRequest!
        
        if method == .get{
            //strURL = strURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            urlRequest = URLRequest(url: url.appendingPathComponent(path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!))
        }else{
            urlRequest = URLRequest(url: url.appendingPathComponent(path))
        }
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

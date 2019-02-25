//
//  NetworkManager.swift
//  MovieGuide
//
//  Created by Omer  on 22.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//
import Foundation

import Alamofire
import SwiftyJSON

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    
    //Sorgu metodunun parametrelerini ve fonksiyonun kedisini olusturuyoruz.
    func request( url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding : ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion : @escaping(_ code : Int?, _ jsonObject: JSON?, _ error: Error?) -> () ){
        
        let requestPath = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        let requestHeaders = (headers ?? Constants.getDefaultHeaders()).merging(Constants.getDefaultHeaders()){ (_, new) in new }
        NetworkManager.sharedInstance.logRequest(url: requestPath, method: method, parameters: parameters, encoding: encoding, headers: requestHeaders)
        .validate(statusCode: 200..<500)
        .validate(contentType: ["application/json"])
            .responseJSON { (responseObject) in
            
                Utils.printResponse(response: responseObject)
                
                if responseObject.result.isSuccess {
                    if let responseJson = responseObject.result.value {
                        completion(responseObject.response?.statusCode, JSON(responseJson), nil) // basarili olursa gelen datayi atamak icin.
                    } else {
                        completion(nil, nil, nil)
                    }
                }
                if responseObject.result.isFailure {
                    completion(nil, nil, responseObject.result.error) // fail olursa gelecek error icin.
                }
        }
    }
    
    
    // sorguyu loglamak icin kullandigimiz fonksiyon
    func logRequest (
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
        ) -> DataRequest {
        let request = SessionManager.default.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    
        #if DEBUG
        if let req = request.request {
            print("\n -->\(req.httpMethod!) \(req.url!)")
            if let body = parameters {
                print(" >>BODY: \n \(body)")
            }
            print(" >>HEADERS: \n \(req.allHTTPHeaderFields!)")
        }
        #endif
        return request
    }
    
}


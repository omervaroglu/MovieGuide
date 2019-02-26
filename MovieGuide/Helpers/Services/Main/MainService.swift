//
//  MainService.swift
//  MovieGuide
//
//  Created by Omer  on 22.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class MainService: NSObject {
    
    static let sharedInstance: MainService = {
        let instance = MainService()
        return instance
    }()
    
    func getTopRatedMovies( completion: @escaping( _ categoryresponse: BaseMovieModel?, _ error: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getPath(path: "movie/top_rated"), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJson, error in
            if error == nil {
                if let json = responseJson {
                    let response = Mapper<BaseMovieModel>().map(JSONObject: json.dictionaryObject)
                    if let response = response, response.page == 1 {
                        completion(response, nil)
                    }else {
                        completion(nil, "sunucuda bir hata olustu")
                    }
                }else {
                    completion(nil, "sunucuda bir hata olustu.")
                }
                
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
            
        }
    }
}

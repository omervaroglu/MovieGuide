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
    
    // movies icin gerekli servisler
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
    
    func getPopularMovies( completion: @escaping( _ categoryresponse: BaseMovieModel?, _ error: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getPath(path: "movie/popular"), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJson, error in
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
    
    func getNowPlayingMovies( completion: @escaping( _ categoryresponse: BaseMovieModel?, _ error: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getPath(path: "movie/now_playing"), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJson, error in
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
    
    func getMoviesDetail(_ isMovie: Bool, _ id: Int, completion: @escaping( _ _: MovieDetail?, _ error: String?) -> ()) {
        //true veya false oldugunu karsilastirdigimiz minik kod
        let path: String = isMovie ? Constants.getPath(path: "movie/\(id)") : Constants.getPath(path: "tv/\(id)")
        
        NetworkManager.sharedInstance.request(url: path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJson, error in
            if error == nil {
                if let json = responseJson {
                    let response = Mapper<MovieDetail>().map(JSONObject: json.dictionaryObject)
                    if let response = response, response.id == id { // nil sorgusu yapabilmek icin jsondan gelen idleri karsilastirdim
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
    
    func getMoviesDetailForCast(_ id: Int, completion: @escaping(_ _: MovieCastDetail?, _ error: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getPath(path: "movie/\(id)/credits"), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJson, error in
            if error == nil {
                if let json = responseJson {
                    let response = Mapper<MovieCastDetail>().map(JSONObject: json.dictionaryObject)
                    if let response = response, response.id == id   { // nil sorgusu yapabilmek icin jsondan gelen idleri karsilastirdim
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
    //------------------------
    //TV icin gerekli servisler
    func getTopRatedTv( completion: @escaping( _ categoryresponse: BaseTvModel?, _ error: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getPath(path: "tv/top_rated"), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJson, error in
            if error == nil {
                if let json = responseJson {
                    let response = Mapper<BaseTvModel>().map(JSONObject: json.dictionaryObject)
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
    func getPopularTv( completion: @escaping( _ categoryresponse: BaseTvModel?, _ error: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getPath(path: "tv/popular"), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJson, error in
            if error == nil {
                if let json = responseJson {
                    let response = Mapper<BaseTvModel>().map(JSONObject: json.dictionaryObject)
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

//
//  Constant.swift
//  MovieGuide
//
//  Created by Omer  on 22.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

@objc public class Constants: NSObject {
    
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    static let tvImageUrl = "https://image.tmdb.org/t/p/w300"
    
    static let apiKey = "f7dea668cf80a25035af6e29f6e05c5e"
    
    static var udid = UIDevice.current.identifierForVendor!.uuidString

    static func getPath(path: String) -> String {
        return baseUrl+path+"?api_key=\(apiKey)"
    }
    
    static func getDefaultHeaders()-> [String:String]{
        return [
            "Content-Type": "application/json",
            "udid": Constants.udid,
        ]
    }
}

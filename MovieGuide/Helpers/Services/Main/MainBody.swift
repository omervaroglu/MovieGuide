//
//  MainBody.swift
//  MovieGuide
//
//  Created by Omer  on 25.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import Alamofire


class MainBody: NSObject {
    
    static let sharedInstance: MainBody = {
        let instance = MainBody()
        return instance
    }()
    
    func getTopRatedMovies() -> Parameters {
        let json : [String: Any] = [
        "Type" : "Movie",
        "Category": "top_rated"
        ]
        return json
    }
}

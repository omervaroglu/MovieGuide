//
//  MoviesModel.swift
//  MovieGuide
//
//  Created by Omer  on 29.01.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Movies: Mappable {
    
    public var movies : [Movie]?
    public var page : Int?
    
    public init?(map: Map) {
        
    }
    
    public mutating func mapping(map: Map) {
        movies <- map["results"]
        page <- map["page"]
    }

}

public struct Movie: Mappable {
    
    public var vote_average : Double?
    public var title : String?
    
    public init?(map: Map) {

    }
    
    public mutating func mapping(map: Map) {
        vote_average <- map["vote_avarage"]
        title <- map["title"]
    }


}


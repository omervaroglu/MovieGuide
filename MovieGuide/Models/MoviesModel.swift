//
//  MoviesModel.swift
//  MovieGuide
//
//  Created by Omer  on 29.01.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation

public struct movies : Codable {
    public var results : [result]
}

public struct result : Codable {
    public var vote_average : Double
    public var title : String
    public var poster_path : URL
    
}

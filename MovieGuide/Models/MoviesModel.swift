//
//  MoviesModel.swift
//  MovieGuide
//
//  Created by Omer  on 29.01.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation


public struct Movies : Codable {
    public var page : Int?
    public var results : [result]
    init ( resultsList results : [result] ) {
        self.results = results
    }
}

public struct result : Codable {
    public let vote_average : Double
    public let title : String
    public let poster_path : URL
    
}

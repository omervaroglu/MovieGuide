//
//  MoviesModel.swift
//  MovieGuide
//
//  Created by Omer  on 29.01.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation

public struct Movies: Codable {
     public var results : [Result]
    
    init (results: [Result]) {
        self.results = results
    }
}

public struct Result: Codable {
     public var vote_average : Double
     public var title : String
     public var poster_path : String
    
    init (vote_average : Double, title : String, poster_path: String) {
        self.vote_average = vote_average
        self.title = title
        self.poster_path = poster_path

    }
    
}


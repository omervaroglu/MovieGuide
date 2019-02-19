//
//  MovieGuideModel.swift
//  MovieGuide
//
//  Created by Omer  on 18.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation


class MovieGuideModel {
    
    var movieList = Movies(results: [])
    var resultList = Result(vote_average: 1.0, title: "", poster_path: "")
    
    
    func getData(moviesType : String, boolentype : Bool ) {
        var dataType = ""
        
        if boolentype == true {
            dataType = "/movie/"
        }else {
            dataType = "/tv/"
        }
        
        let baseURL = "https://api.themoviedb.org/3"
        let key = "/?api_key=f7dea668cf80a25035af6e29f6e05c5e"
        
        let newURL = baseURL + dataType + moviesType + key
        let url = URL(string: newURL)!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        guard let movies = try? decoder.decode(Movies.self, from: data) else {
            print("error")
            return
        }
        
        print(movies.results)
        self.movieList = movies
        for result in movies.results {
            print(result.title)
            self.resultList = result
        }
        
// iceride dondurdugun veriyi controllerda nasil gosterceksin
        
        
    }

}

//
//  MovieGuideModel.swift
//  MovieGuide
//
//  Created by Omer  on 18.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation


class MovieGuideModel {
    
    var movieArray : result
    
     init() {
        movieArray =  as result
        //yukarida olusturdugumuz modeli tutmak icin gerekli olan initilazation islemi
    }
    
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
        
        var movie = try! decoder.decode(result.self, from: data)
        movie = self.movieArray
    }

}


// resulti istenen tipte bu sayfada belirtilmesi gerekiyor.

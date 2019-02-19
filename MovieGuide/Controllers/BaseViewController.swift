//
//  ViewController.swift
//  MovieGuide
//
//  Created by Omer  on 29.01.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import UIKit

//let myUrl = "https://api.themoviedb.org/3/movie/popular?api_key=f7dea668cf80a25035af6e29f6e05c5e"
//let url = URL(string: myUrl)
//let data = try! Data(contentsOf: url!)
//let decoder = JSONDecoder()

class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func getData(moviesType : String, boolentype : Bool ) {
//        var dataType = ""
//
//        if boolentype == true {
//            dataType = "movie"
//        }else {
//            dataType = "tv"
//        }
//
//        let baseURL = "https://api.themoviedb.org/3/"
//        let key = "?api_key=f7dea668cf80a25035af6e29f6e05c5e"
//
//        let newURL = baseURL + dataType + moviesType + key
//        let url = URL(string: newURL)
//        let data = try! Data(contentsOf: url!)
//        let decoder = JSONDecoder()
//
//        do {
//            var movie = try decoder.decode(Movies.self, from: data)
//            var resultMovie = try decoder.decode(result.self, from: data)
//            resultMovie = popularMovie
//            print(movie.results)
//
//        } catch {
//            print(error)
//        }
//        print(popularMovie)
//
//    }
}


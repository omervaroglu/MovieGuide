//
//  MoviesScrennController.swift
//  MovieGuide
//
//  Created by Omer  on 31.01.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import UIKit
import Foundation
import PKHUD

class MoviesScreenController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var moviesList = [Result]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.delegate = self
        tableView.dataSource = self
        
        getMoviesList()
    }
    
    func getMoviesList() {
        MainService.sharedInstance.getTopRatedMovies(completion: {(moviesResponse, error) in
            if error != nil {
                self.moviesList = moviesResponse!.results ?? []
                print("dustu")
            }else {
                let alert = UIAlertController(title: "HATA", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("click the 'OK'")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
}

extension MoviesScreenController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.numberOfLines = "\(moviesList.toJSONString())"
        return cell
        
        //cell i listeleyebil.
        
    }
    
}

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
    
    var moviesList = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func getMoviesList() {
        MainService.sharedInstance.getTopRatedMovies(completion: {(moviesResponse, error) in
            if error == nil {
                self.moviesList = moviesResponse!.movies ?? []
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        cell.textLabel?.text = "\(moviesList[indexPath.row].title ?? "")"
        
        return cell
    }
    
}

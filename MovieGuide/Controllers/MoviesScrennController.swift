//
//  MoviesScrennController.swift
//  MovieGuide
//
//  Created by Omer  on 31.01.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import UIKit
import Foundation

class MoviesScreenController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var modelMovie = MovieGuideModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(modelMovie.movieList.results)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 1
        return cell
    }
    
    func listData () {
        self.modelMovie.getData(moviesType: "popular", boolentype: true)
        
    }

    
}

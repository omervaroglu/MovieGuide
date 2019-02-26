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
import Kingfisher

class MoviesScreenController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var moviesList = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMoviesList()
    }
    
    func getMoviesList() {
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getTopRatedMovies(completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.moviesList = moviesResponse?.movies ?? []
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "TopRatedMovieCell", bundle: nil), forCellReuseIdentifier: "TopRatedMovieCell" )
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedMovieCell", for: indexPath) as! TopRatedMovieCell
        //cell.textLabel?.text = "\(moviesList[indexPath.row].title ?? "")"
        cell.topRatedCollectionView.delegate = self
        cell.topRatedCollectionView.dataSource = self
        cell.topRatedCollectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 206
        
    }
}

extension MoviesScreenController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "TopRatedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionCell", for: indexPath) as! TopRatedCollectionCell
        
        cell.collectionViewImage.kf.setImage(with: URL(string: Constants.imageUrl+moviesList[indexPath.row].backdrop_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width-40
        let height = width*281/500
        return CGSize(width: width, height: height)
    }
    
}

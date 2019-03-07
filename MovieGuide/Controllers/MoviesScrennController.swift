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
    
    var topRatedMovies = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    var popularMovies = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    var nowPlayingMovies = [Movie]() {
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
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getTopRatedMovies(completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.topRatedMovies = moviesResponse?.movies ?? []
                print("topRated")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })
        MainService.sharedInstance.getPopularMovies(completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.popularMovies = moviesResponse?.movies ?? []
                print("Popular")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })        
        MainService.sharedInstance.getNowPlayingMovies(completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.nowPlayingMovies = moviesResponse?.movies ?? []
                print("NowPlaying")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })
    }
}

extension MoviesScreenController:  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            tableView.register(UINib(nibName: "TopRatedMovieCell", bundle: nil), forCellReuseIdentifier: "TopRatedMovieCell" )
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedMovieCell", for: indexPath) as! TopRatedMovieCell
            cell.topRatedCollectionView.tag = 1
            cell.topRatedCollectionView.delegate = self
            cell.topRatedCollectionView.dataSource = self
            cell.topRatedCollectionView.reloadData()
            return cell
            
        case 1:
            
            tableView.register(UINib(nibName: "PopularMoviesCell", bundle: nil), forCellReuseIdentifier: "PopularMoviesCell" )
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesCell", for: indexPath) as! PopularMoviesCell
            cell.popularMoviesCollectionView.tag = 2
            cell.popularMoviesCollectionView.delegate = self
            cell.popularMoviesCollectionView.dataSource = self
            cell.popularMoviesCollectionView.reloadData()
            return cell
            
        case 2:
            
            tableView.register(UINib(nibName: "PopularMoviesCell", bundle: nil), forCellReuseIdentifier: "PopularMoviesCell" )
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesCell", for: indexPath) as! PopularMoviesCell
            cell.popularMoviesCollectionView.tag = 3
            cell.popularMoviesCollectionView.delegate = self
            cell.popularMoviesCollectionView.dataSource = self
            cell.popularMoviesCollectionView.reloadData()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 16, y: 10, width: self.view.frame.width-16, height: 40))
        switch section {
        case 0:
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.text = "TOP RATED MOVIES"
            break
        case 1:
            label.text = "Now Playing"
        default:
            label.text = "Popular"
        }
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 206
        default:
            return 286
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension MoviesScreenController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return topRatedMovies.count
        case 2:
            return nowPlayingMovies.count
        case 3:
            return popularMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch collectionView.tag {
        case 1:
            collectionView.register(UINib(nibName: "TopRatedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionCell", for: indexPath) as! TopRatedCollectionCell
            
            cell.collectionViewImage.kf.setImage(with: URL(string: Constants.imageUrl+topRatedMovies[indexPath.row].backdrop_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            
            return cell
            
        case 2:
            
            collectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMoviesCollectionCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionCell", for: indexPath) as! PopularMoviesCollectionViewCell
            
            cell.popularCollectionImageView.kf.setImage(with: URL(string: Constants.imageUrl+nowPlayingMovies[indexPath.row].poster_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.popularCollectionLabel.text = nowPlayingMovies[indexPath.row].title
            
            return cell
        
        case 3 :
            collectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMoviesCollectionCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionCell", for: indexPath) as! PopularMoviesCollectionViewCell
            
            cell.popularCollectionImageView.kf.setImage(with: URL(string: Constants.imageUrl+popularMovies[indexPath.row].poster_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.popularCollectionLabel.text = popularMovies[indexPath.row].title
            
            return cell

        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->
        CGSize {
            switch collectionView.tag {
            case 1:
                
                let width = self.view.frame.width-60
                let height = width*281/500
                return CGSize(width: width+16, height: height)
            
            case 2:
                
                let width = self.view.frame.width*2/5
                let height = width*3/2 + 72
                return CGSize(width: width, height: height)
            
            default:
            
                let width = self.view.frame.width*2/5
                let height = width*3/2 + 72
                return CGSize(width: width, height: height)
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MoviesDetailTableViewController") as! MoviesDetailTableViewController
        switch collectionView.tag {
        case 1:
            vc.movie = topRatedMovies[indexPath.row]
        case 2:
            vc.movie = nowPlayingMovies[indexPath.row]
        case 3:
            vc.movie = popularMovies[indexPath.row]
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

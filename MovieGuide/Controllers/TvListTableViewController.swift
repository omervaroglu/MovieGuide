//
//  TvListTableViewController.swift
//  MovieGuide
//
//  Created by Ömer Varoğlu on 28.07.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

class TvListTableViewController : UITableViewController {
    
    var topRatedTv = [Tv]() {
        didSet {
            tableView.reloadData()
        }
    }
    var popularTv = [Tv]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        getTvList()
    }
    
    func getTvList()  {
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getPopularTv(completion: { (moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.popularTv = moviesResponse?.tvs ?? []
                print("popularTV")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getTopRatedTv(completion: { (moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.topRatedTv = moviesResponse?.tvs ?? []
                print("topRatedTV")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return popularTv.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 286
        default:
            return 300
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            tableView.register(UINib(nibName: "PopularMoviesCell", bundle: nil), forCellReuseIdentifier: "PopularMoviesCell" )
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesCell", for: indexPath) as! PopularMoviesCell
            cell.popularMoviesCollectionView.delegate = self
            cell.popularMoviesCollectionView.dataSource = self
            cell.popularMoviesCollectionView.reloadData()
            return cell
        case 1:
            tableView.register(UINib(nibName: "PopularTvCell", bundle: nil), forCellReuseIdentifier: "PopularTvCell" )
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTvCell", for: indexPath) as! PopularTvCell
            cell.popularTvImage.kf.setImage(with: URL(string: Constants.tvImageUrl+popularTv[indexPath.row].backdrop_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.nameLabel.text = popularTv[indexPath.row].name
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 16, y: 10, width: self.view.frame.width-16, height: 40))
        switch section {
        case 0:
            label.text = "Top Rated"
            break
        default:
            label.text = "Popular"
        }
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 50
    }

    
}
extension TvListTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRatedTv.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMoviesCollectionViewCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for: indexPath) as! PopularMoviesCollectionViewCell
        
        cell.popularCollectionImageView.kf.setImage(with: URL(string: Constants.imageUrl+topRatedTv[indexPath.row].poster_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        cell.popularCollectionLabel.text = topRatedTv[indexPath.row].name
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->
        CGSize {
            let width = self.view.frame.width*2/5
            let height = width*2 + 72
            return CGSize(width: width, height: height)
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MoviesDetailTableViewController") as! MoviesDetailTableViewController
        vc.movie = Movie(tv: topRatedTv[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

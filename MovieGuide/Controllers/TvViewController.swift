//
//  TvViewController.swift
//  MovieGuide
//
//  Created by Omer  on 12.03.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
import Kingfisher

class TvViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
}
extension TvViewController:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1 :
            return 0
        case 2 :
            return popularTv.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            tableView.register(UINib(nibName: "PopularMoviesCell", bundle: nil), forCellReuseIdentifier: "PopularMoviesCell" )
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesCell", for: indexPath) as! PopularMoviesCell
            cell.popularMoviesCollectionView.tag = 0
            cell.popularMoviesCollectionView.delegate = self
            cell.popularMoviesCollectionView.dataSource = self
            cell.popularMoviesCollectionView.reloadData()
            return cell
        case 1:
            tableView.register(UINib(nibName: "TopRatedMovieCell", bundle: nil), forCellReuseIdentifier: "TopRatedMovieCell" )
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedMovieCell", for: indexPath) as! TopRatedMovieCell
            cell.topRatedCollectionView.tag = 1
            cell.topRatedCollectionView.delegate = self
            cell.topRatedCollectionView.dataSource = self
            cell.topRatedCollectionView.reloadData()
            return cell
        case 2 :
            tableView.register(UINib(nibName: "PopularTvCell", bundle: nil), forCellReuseIdentifier: "PopularTvCell" )
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTvCell", for: indexPath) as! PopularTvCell
            
            cell.popularTvImage.kf.setImage(with: URL(string: Constants.tvImageUrl+popularTv[indexPath.row].backdrop_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.nameLabel.text = popularTv[indexPath.row].name
            return cell
        default:
           return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 286
        default:
            return 286
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 16, y: 10, width: self.view.frame.width-16, height: 40))
        switch section {
        case 0:
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.text = "TV"
            break
        default:
            label.text = "Popular"
        }
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 50
    }
}

extension TvViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return popularTv.count
        case 1:
            return topRatedTv.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            collectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMoviesCollectionViewCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for: indexPath) as! PopularMoviesCollectionViewCell
            
            cell.popularCollectionImageView.kf.setImage(with: URL(string: Constants.imageUrl+popularTv[indexPath.row].poster_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.popularCollectionLabel.text = popularTv[indexPath.row].name
            
            return cell
        case 1:
            collectionView.register(UINib(nibName: "TopRatedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionCell", for: indexPath) as! TopRatedCollectionCell
            
            cell.collectionViewImage.kf.setImage(with: URL(string: Constants.imageUrl+topRatedTv[indexPath.row].backdrop_path!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            
            //burasi scrollu degistirdigimiz yer
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
            //
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
            case 0:
                let width = self.view.frame.width*2/5
                let height = width*3/2 + 72
                return CGSize(width: width, height: height)
            default:
                let width = self.view.frame.width*2/5
                let height = width*3/2 + 72
                return CGSize(width: width, height: height)
            }
    }
}

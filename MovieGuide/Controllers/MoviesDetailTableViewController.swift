//
//  MoviesDetailScreenController.swift
//  MovieGuide
//
//  Created by Omer  on 28.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
import Kingfisher

class MoviesDetailTableViewController: UITableViewController {
       
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var posterImage: MovieImageView!
    @IBOutlet weak var backPoster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie?
    var movieDetail: MovieDetail?{
        didSet{
            setUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.navigationController?.navigationBar.isHidden = true
        getDetails(movie?.id ?? 0)
    }
    
    func setUI(){
        backPoster.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.backdrop_path)!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        
        posterImage.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.poster_path)!), placeholder: nil, options: [.cacheOriginalImage] , progressBlock: nil, completionHandler: nil)
        
        descriptionLabel.text = movieDetail?.overview
    }
    
    func getDetails(_ movieId : Int) {
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getMoviesDetail(movieId, completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.movieDetail = moviesResponse
                print("Movie detail ")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })
    }
}

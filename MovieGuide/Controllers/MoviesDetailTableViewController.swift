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
import Cosmos

class MoviesDetailTableViewController: UITableViewController {
       
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var posterImage: MovieImageView!
    @IBOutlet weak var backPoster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kindOfMovieLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var rateLabel: UILabel!
    
    var movie: Movie?
    var movieDetail: MovieDetail?{
        didSet{
            setUI()
            if let genres = movieDetail?.genres {
                genreString = ""
                for item in genres {
                    genreString = "\(genreString!), \(item.name!)"
                }
                genreString?.removeFirst()
                genreString?.removeFirst()
            }
        }
    }
    var genreString: String? {
        didSet{
           kindOfMovieLabel.text = genreString
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
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUI(){
        backPoster.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.backdrop_path)!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        
        posterImage.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.poster_path)!), placeholder: nil, options: [.cacheOriginalImage] , progressBlock: nil, completionHandler: nil)
        
        descriptionLabel.text = movieDetail?.overview
        titleLabel.text = movieDetail?.original_title
        rateLabel.text = String(describing: movieDetail?.vote_average ?? 0.0)
        cosmosView.rating = (movieDetail?.vote_average ?? 0.0)/2
        cosmosView.settings.fillMode = .precise
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

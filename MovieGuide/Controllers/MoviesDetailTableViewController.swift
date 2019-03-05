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
    
    @IBOutlet weak var posterImage: MovieImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie?
    var movieDetail: MovieDetail?{
        didSet{
            setUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        
        
        
    }
    
    func setUI(){
        posterImage.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.poster_path)!), placeholder: nil, options: [.cacheOriginalImage] , progressBlock: nil, completionHandler: nil)
        descriptionLabel.text = movieDetail?.overview
    }
    
    func getDetails() {
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getMoviesDetail(movie?.id ?? 0, completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.movieDetail = moviesResponse
                print("Movie detail ")
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

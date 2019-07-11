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
import CoreImage
import AVKit
import CoreData

class MoviesDetailTableViewController: UITableViewController {
       
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var posterImage: MovieImageView!
    @IBOutlet weak var backPoster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kindOfMovieLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var favButton: UIButton!
    

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
    // Cast i gostermem icin gerekli modeli tanimlama
    var moviesCast = [Cast](){
        didSet {
            castCollectionView.reloadData()
        }
    }
    var favMovei : [Int] = []
    var favTv : [Int] = []
    
    var selectedItem : Bool?
    let defaults = UserDefaults.standard
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "selectedItem") == true {
            self.favButton.setBackgroundImage(UIImage(named: "icStarSelected"), for: .normal)
        }else {
            self.favButton.setBackgroundImage(UIImage(named: "icStar"), for: .normal)
        }

        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.navigationController?.navigationBar.isHidden = true
        getDetails(movie!.isMovie ,(movie?.id ?? 0))
        }
    override func viewDidDisappear(_ animated: Bool) {
        defaults.set(favMovei, forKey: "favMovei")
        defaults.set(favTv, forKey: "favTv")
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func favouriteButton(_ sender: UIButton) {
        selectedItem = movie?.isSelected ?? false
        defaults.set(selectedItem, forKey: "selectedItem")
    
        
        
//        if defaults.bool(forKey: "selectedItem"){
//            movie?.isSelected = false
//            for movie in favMovei {
//                if movie == self.movieDetail?.id {
//                    self.favButton.setBackgroundImage(UIImage(named: "icStar"), for: .normal)
//                }
//            }
//            if movie!.isMovie {
//                self.favMovei.reverse()
//            }else {
//                self.favTv.reverse()
//            }
//        } else {
//            movie?.isSelected = true
//            //self.favMovei.append(movieDetail?.id ?? 0)
//            self.favButton.setBackgroundImage(UIImage(named: "icStarSelected"), for: .normal)
//            if movie!.isMovie {
//                self.favMovei.append(movieDetail?.id ?? 0)
//            }else {
//                self.favTv.append(movieDetail?.id ?? 0)
//            }
//        }
//        selectedItem = movie?.isSelected ?? false
//        defaults.set(selectedItem, forKey: "selectedItem")
        
        
//        if movie?.isMovie == true {
//            self.favMovei.append(movie!)
//            movie?.isSelected = true
//            if movie?.isSelected == true {
//                sender.setBackgroundImage(UIImage(named: "icStarSelected"), for: .normal)
//            } else {
//                sender.setBackgroundImage(UIImage(named: "icStar"), for: .normal)
//                self.favMovei.remove(at: movie?.id ?? 0)
//            }
//        } else {
//            self.favTv.append(movie!)
//            if movie?.isSelected == true {
//                sender.setBackgroundImage(UIImage(named: "icStarSelected"), for: .normal)
//            } else {
//                sender.setBackgroundImage(UIImage(named: "icStar"), for: .normal)
//                self.favMovei.reverse()
//            }
//        }
//        print(favTv.count)
//        print("favori tik.")
    }


    func setUI(){
        backPoster.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.backdrop_path)!), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil) { image, _, _, _ in
            if image == nil {
                self.backPoster.image = UIImage(named: "profile")
            }
            self.titleLabel.textColor = self.backPoster.image?.averageColor!.realInverse()
            self.castCollectionView.backgroundColor = .white
            self.view.backgroundColor = .white
            self.descriptionLabel.textColor = self.backPoster.image?.averageColor!.realInverse()
            self.rateLabel.textColor = self.backPoster.image?.averageColor!.realInverse()
            self.kindOfMovieLabel.textColor = self.backPoster.image?.averageColor!.realInverse()
       
        }
        
        posterImage.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.poster_path)!), placeholder: nil, options: [.cacheOriginalImage] , progressBlock: nil, completionHandler: nil)
        
        descriptionLabel.text = movieDetail?.overview
        titleLabel.text = movieDetail?.original_title
        rateLabel.text = String(describing: movieDetail?.vote_average ?? 0.0)
        cosmosView.rating = (movieDetail?.vote_average ?? 0.0)/2
        cosmosView.settings.fillMode = .precise
    }
    
    func getDetails(_ isMovie: Bool, _ movieId : Int) {
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getMoviesDetail(isMovie, movieId, completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.movieDetail = moviesResponse
                print("Movie detail")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })
        
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getMoviesDetailForCast(movieId, completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.moviesCast = moviesResponse?.cast ?? []
                print("Movie cast")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })
    }
}

extension MoviesDetailTableViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "CastCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionCell", for: indexPath) as! CastCollectionCell
        
        if let image = backPoster.image {
            cell.CastView.backgroundColor = image.averageColor?.inverse()
        }
        
        cell.CastCollectionImageView.kf.setImage(with: URL(string: Constants.imageUrl+(moviesCast[indexPath.row].profile_path ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil){ (image, _, _, _) in
            if image == nil {
                cell.CastCollectionImageView.image = UIImage(named: "profile")
            }
        }
        cell.CastCollectionNameLabel.text = self.moviesCast[indexPath.row].name ?? ""
        cell.CastCollectionNameLabel.textColor = self.backPoster.image?.averageColor!.realInverse()
        //self.castCollectionView.reloadItems(at: [indexPath])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->
        CGSize {
                let width = collectionView.frame.width/3
                let height = collectionView.frame.height-8
                return CGSize(width: width, height: height)
    }
}

extension UIImage {
    
    var averageColor: UIColor? {
        guard let inputImage = self.ciImage ?? CIImage(image: self) else { return nil }
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: CIVector(cgRect: inputImage.extent)])
            else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [CIContextOption.workingColorSpace : kCFNull])
        let outputImageRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: outputImageRect, format: CIFormat.RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
extension UIColor {
    func inverse () -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 5.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            if r < 0.6 && g < 0.6 && b < 0.6 { // renk siyaha yakinsa beyaz gondermesi icin
                return UIColor(red: 1, green: 1, blue: 1, alpha: a)
            }// aksi halde zit rengini alacak
            if r > 0.4 && g > 0.4 && b > 0.4 { // renk beyaza yakinsa siyah gondermesi icin
                return UIColor(red: 0, green: 0, blue: 0, alpha: a)
            }// aksi halde zit rengini alacak
            return UIColor(red: (1.0-r), green: (1.0 - g), blue: (1.0 - b), alpha: a)
        }
        return .black // Return a default colour
    }
    
    func realInverse () -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: (1.0-r), green: (1.0 - g), blue: (1.0 - b), alpha: a)
        }
        return .black // Return a default colour
    }
}

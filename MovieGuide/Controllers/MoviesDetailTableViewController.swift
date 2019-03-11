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
        
        PKHUD.sharedHUD.show()
        MainService.sharedInstance.getMoviesDetailForCast(movieId, completion: {(moviesResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.moviesCast = moviesResponse?.cast ?? []
                print("Movie cast ")
            }else {
                ViewUtils.showAlert(withController: self, title: "Uyarı", message: "Sunucuda bir hata olustu.")
            }
        })
    }
    func fastColorAvg(_ inputImage: CIImage) -> UIColor? {
        
        guard let avgFilter = CIFilter(name: "CIAreaAverage") else { return nil }
        avgFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let imageRect = inputImage.extent
        avgFilter.setValue(CIVector(cgRect: imageRect), forKey: kCIInputExtentKey)
        let newImage = UIImage(ciImage: avgFilter.outputImage!)
        let newCol = extractColor(newImage)
        return newCol
    }
    
    
    func extractColor(_ theImage: UIImage) -> UIColor? {
        var pixel = Pixel(red: 0, green: 0, blue: 0, alpha: 0)
        if let imageData = theImage.tiffRepresentation {
            guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
            let maskRef = CGImageSourceCreateImageAtIndex(source, 0, nil)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            //            var bitmapInfo = CGBitmapInfo.ByteOrder32Big.union(CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue))
            let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
            
            context?.draw(maskRef!, in: CGRect(x: 0, y: 0,width: 1,height: 1))
            //            context?.draw(in: CGRect(x: 0, y: 0,width: 1,height: 1),image: maskRef!)
            let r = CGFloat(pixel.red) / CGFloat(255.0)
            let g = CGFloat(pixel.green) / CGFloat(255.0)
            let b = CGFloat(pixel.blue) / CGFloat(255.0)
            let a = CGFloat(pixel.alpha) / CGFloat(255.0)
            return UIColor(calibratedRed: r, green: g, blue: b, alpha: a)
        }
        return nil
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
            
        cell.CastCollectionImageView.kf.setImage(with: URL(string: Constants.imageUrl+(moviesCast[indexPath.row].profile_path ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil){ (image, _, _, _) in
            if image == nil {
                cell.CastCollectionImageView.image = UIImage(named: "profile")
            }
        }
            cell.CastCollectionNameLabel.text = self.moviesCast[indexPath.row].name ?? ""
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->
        CGSize {
                let width = collectionView.frame.width/3
                let height = collectionView.frame.height-8
                return CGSize(width: width, height: height)
    }
    
}

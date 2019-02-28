//
//  PopularMoviesCollectionCell.swift
//  MovieGuide
//
//  Created by Omer  on 28.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var popularCollectionImageView: MovieImageView!
    @IBOutlet weak var popularCollectionLabel: UILabel!
    
    override func awakeFromNib() {
        popularCollectionImageView.layer.cornerRadius = 10
        popularCollectionImageView.layer.shadowColor = UIColor.black.cgColor
        popularCollectionImageView.layer.shadowRadius = 5
        popularCollectionImageView.layer.shadowOpacity = 10
        popularCollectionImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        popularCollectionImageView.layer.masksToBounds = true
        popularCollectionImageView.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}

//
//  CastCollectionCell.swift
//  MovieGuide
//
//  Created by Omer  on 8.03.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

class CastCollectionCell: UICollectionViewCell {
    @IBOutlet weak var CastCollectionImageView: MovieImageView!
    @IBOutlet weak var CastCollectionNameLabel: UILabel!
    @IBOutlet weak var CastView: UIView!
    
    override func awakeFromNib() {
        CastView.layer.cornerRadius = 10
        CastView.layer.shadowColor = UIColor.black.cgColor
        CastView.layer.shadowOffset = CGSize(width: 0, height: 1)
        CastView.layer.shadowOpacity = 0.2
        CastView.layer.shadowRadius = 5
//        CastView.layer.masksToBounds = false
    }
}

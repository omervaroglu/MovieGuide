//
//  PopularTvCell.swift
//  MovieGuide
//
//  Created by Omer  on 13.03.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

class PopularTvCell: UITableViewCell {
    
    @IBOutlet weak var popularTvImage: MovieImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        cellView?.layer.cornerRadius = 10.0
        cellView?.layer.shadowColor = UIColor.black.cgColor
        cellView?.layer.shadowOffset = CGSize(width: 0, height: 1)
        cellView?.layer.shadowOpacity = 0.2
        cellView?.layer.shadowRadius = 5
//        CastView.layer.masksToBounds = false
    }
}

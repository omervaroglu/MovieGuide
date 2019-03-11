//
//  MovieImageVIew.swift
//  MovieGuide
//
//  Created by Omer  on 26.02.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

class MovieImageView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 3)
//        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
//        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
//        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = true
        clipsToBounds = true
    }
}

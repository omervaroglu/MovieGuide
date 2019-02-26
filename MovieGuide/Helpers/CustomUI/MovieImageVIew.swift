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
        layer.cornerRadius = 15
    }
}

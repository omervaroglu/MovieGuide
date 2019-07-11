//
//  ViewUtils.swift
//  MovieGuide
//
//  Created by Omer  on 6.03.2019.
//  Copyright © 2019 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

class ViewUtils {
    
    static func showAlert(withController viewController: UIViewController, title: String, message: String?){
        
        let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Tamam", style: .default) { (action:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)  
        viewController.present(alertController, animated: true, completion:nil)
    }
    //ViewUtils.showAlert(withController: self, title: "Uyarı", message: "hata mesaji buraya")
}

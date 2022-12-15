//
//  CommonUtils.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 15/12/22.
//

import UIKit

class CommonUtils {
    class func showGenericAlert(message: String, viewController: UIViewController) {
 
        
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true)
    }
}

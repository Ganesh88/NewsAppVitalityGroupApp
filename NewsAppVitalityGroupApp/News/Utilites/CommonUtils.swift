//
//  CommonUtils.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 15/12/22.
//

import UIKit
import MBProgressHUD

class CommonUtils {
    class func showGenericAlert(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    class func getFormattedDate(serverTime: String, fromFormat: String , toFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        let serverDate = formatter.date(from: serverTime)
        formatter.dateFormat = toFormat
        if let date = serverDate {
            let internationalTime = formatter.string(from: date)
            return internationalTime
        }
        else {
            return ""
        }
    }
}


extension UIViewController {
    func showHud() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading"
        hud.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

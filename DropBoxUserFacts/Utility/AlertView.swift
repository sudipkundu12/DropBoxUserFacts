//
//  AlertView.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 14/12/20.
//

import UIKit

class AlertView {

    static func displayAlert(title: String, message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)

        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        viewController.present(alertController, animated: true, completion: nil)
    }

}

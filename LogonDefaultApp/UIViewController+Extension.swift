//
//  UIViewController+Extension.swift
//  LoginDefaultApp
//
//  Created by Vaibhav Singh on 05/07/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(_ title: String = "Error", message: String){
        showAlertController(title: title, message: message, addDefaultAction: true)
    }

    func showAlertController(title: String, message: String, actions: [UIAlertAction] = [], addDefaultAction: Bool = false) {
        let alertController = UIAlertController(title: title, message: "\(message)", preferredStyle: .alert)
        if addDefaultAction {
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
        }
        for action in actions {
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }

    func validation (_ regex: String, _ evaluateWith: String) -> Bool{
        if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: evaluateWith){
            return false
        }
        return true
    }
}


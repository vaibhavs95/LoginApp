//
//  PasswordViewController.swift
//  LoginDefaultApp
//
//  Created by Vaibhav Singh on 04/07/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordButton: UIButton!{
        didSet {
            passwordButton.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var usernameField: UITextField!{
        didSet {
            usernameField.delegate = self
        }
    }

    @IBAction func getPassword(_ sender: Any) {
        if (usernameField.text?.isEmpty)! {
            alert(message: "Please enter a Username")
            return
        } else if UserDefaults.standard.value(forKey: usernameField.text!) == nil{
            alert(message: "No Such User Exists")
            return
        }
        guard let user = UserDefaults.standard.value(forKey: usernameField.text!) as? [String : String] else { return }
        guard let recoveredPassword = user[UserKeys.password] else { return }

        let action = UIAlertAction(title: "Back", style: .default, handler: {Void in self.performSegue(withIdentifier: "unwindToLogin", sender: nil)})
        showAlertController(title: "Et Voila!", message: "Your password is : \"\(String(describing: recoveredPassword))\"", actions: [action])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            textField.resignFirstResponder()
            getPassword(passwordButton)
        }
        return true
    }
}



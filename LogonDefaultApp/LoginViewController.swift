//
//  ViewController.swift
//  LogonDefaultApp
//
//  Created by Vaibhav Singh on 29/06/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBAction func unwindToLogin(segue : UIStoryboardSegue) {}

    @IBOutlet weak var usernameTextField: UITextField! {
        didSet {
            usernameTextField.delegate = self
            usernameTextField.placeholder = "Email ID"
            usernameTextField.borderStyle = .roundedRect
            usernameTextField.autocorrectionType = .no
            usernameTextField.autocapitalizationType = .none
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
            passwordTextField.placeholder = "Password"
            passwordTextField.borderStyle = .roundedRect
            passwordTextField.autocorrectionType = .no
            passwordTextField.autocapitalizationType = .none
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.isEnabled = false
            loginButton.layer.cornerRadius = 8
            loginButton.backgroundColor = .lightGray
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = nil
    }

    @IBAction func loginButtonAction(_ sender: Any) {

        guard let username = usernameTextField.text else {
            return
        }
        if UserDefaults.standard.value(forKey: username) == nil {
            alert(message: "No Such User Exists")
            return
        } else {
            guard let user = UserDefaults.standard.value(forKey: usernameTextField.text!) as? [String: String] else { return }
            if user[UserKeys.password] != passwordTextField.text {
                alert(message: "Incorect Password")
                return
            } else {
                if let newVC = storyboard?.instantiateViewController(withIdentifier: "UserDataViewController") as? UserDataViewController
                {
                    newVC.data = user[UserKeys.id]!
                    navigationController?.pushViewController(newVC, animated: true)
                }
            }
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let str = textField.text as NSString? else {
            return false
        }
        let updatedString = str.replacingCharacters(in: range, with: string)

        if (textField == passwordTextField && updatedString.count >= 8 && !((usernameTextField.text?.isEmpty)!)){
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(rgb: 0x007AFF)
        }
        else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.lightGray
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginButtonAction(loginButton)
        }

        return true
    }
}






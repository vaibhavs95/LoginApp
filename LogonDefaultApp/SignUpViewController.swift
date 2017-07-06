//
//  SignUpViewController.swift
//  LoginDefaultApp
//
//  Created by Vaibhav Singh on 30/06/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!{
        didSet {
            signUpButton.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.delegate = self
        }
    }
    @IBOutlet weak var lastNameField: UITextField! {
        didSet {
            lastNameField.delegate = self
        }
    }
    @IBOutlet weak var userNameField: UITextField! {
        didSet {
            userNameField.delegate = self
        }
    }
    @IBOutlet weak var idField: UITextField! {
        didSet {
            idField.delegate = self
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            passwordField.delegate = self
        }
    }
    @IBOutlet weak var confirmPasswordField: UITextField! {
        didSet {
            confirmPasswordField.delegate = self
        }
    }

    @IBAction func signUpAction(_ sender: Any) {
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameField.text,
            let userName = userNameField.text,
            let id = idField.text,
            let password = passwordField.text,
            let confirmPassword = confirmPasswordField.text else
        {return}

        if firstName.isEmpty{
            labelError("First Name can't be empty!")
            shake()
            return
        }
        if userName.isEmpty{
            labelError("Username Field can't be empty!")
            shake()
            return
        }
        if id.isEmpty {
            labelError("ID can't be Empty!")
            shake()
            return
        } else {
            let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
            if !validation(emailRegex, id){
                labelError("Email ID doesn't have the corect format")
                shake()
                return
            }
        }
        if UserDefaults.standard.value(forKey: id) != nil{
            labelError("User with this Email already exists")
            shake()
            return
        }
        let passRegex = "^(?=.*[A-Z].)(?=.*[!@#$&*^%])(?=.*[0-9])(?=.*[a-z]).{8,16}$"
        if !validation(passRegex, password) {
            labelError("Password Format : 1 special character, 1 digit, 1 Uppercase and 1 lowercase character, length: 8-32")
            shake()
            return
        }
        if (password != confirmPassword){
            labelError("Passwords don't match")
            shake()
            return()
        }
        labelError("You have successfully signed up!",.gray)
        let user = [UserKeys.fName : firstName, UserKeys.lName : lastName, UserKeys.id : id, UserKeys.username : userName, UserKeys.password : password]
        UserDefaults.standard.set(user, forKey: id)
        let alertController = UIAlertController(title: "Success", message: "Sign Up Completed Successfully!", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Home", style: .default, handler:{Void in self.performSegue(withIdentifier: "unwindToHome", sender: nil)}  )
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    func shake(count : Float? = nil, for duration : TimeInterval? = nil, withTranslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

        animation.repeatCount = count ?? 5
        animation.duration = (duration ?? 0.1)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -7
        signUpButton.layer.add(animation, forKey: "shake")
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            userNameField.becomeFirstResponder()
        case userNameField:
            idField.becomeFirstResponder()
        case idField:
            passwordField.becomeFirstResponder()
        case passwordField:
            confirmPasswordField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            if signUpButton.isEnabled{
            signUpAction(signUpButton)
            }
        }
        return true
    }

    func labelError(_ message: String,_ color: UIColor? = .red){
        messageLabel.textColor = color
        messageLabel.text = message
    }
}

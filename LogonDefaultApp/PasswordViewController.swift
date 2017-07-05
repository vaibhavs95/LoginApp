//
//  PasswordViewController.swift
//  LoginDefaultApp
//
//  Created by Vaibhav Singh on 04/07/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordButton.layer.cornerRadius = 8
    }

    @IBAction func getPassword(_ sender: Any) {
        if (usernameField.text?.isEmpty)! {
            alert("Please enter a Username")
            return
        } else if UserDefaults.standard.value(forKey: usernameField.text!) == nil{
            alert("No Such User Exists")
            return
        }
        guard let user = UserDefaults.standard.value(forKey: usernameField.text!) as? [String : String] else { return }
        guard let recoveredPassword = user[UserKeys.password] else
        {return}
        let alertController = UIAlertController(title: "Et Voila!", message: "Your password is : \"\(String(describing: recoveredPassword))\"", preferredStyle: .alert)
        let action = UIAlertAction(title: "Back", style: .default, handler: {Void in self.performSegue(withIdentifier: "unwindToLogin", sender: nil)})
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func alert(_ message: String){
        let alertController = UIAlertController(title: "Error", message: "\(message)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Back", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

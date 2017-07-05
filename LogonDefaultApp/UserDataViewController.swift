//
//  UserDataViewController.swift
//  LoginDefaultApp
//
//  Created by Vaibhav Singh on 30/06/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController {

    var data = String()


    @IBOutlet weak var fNameField: UITextField!
    @IBOutlet weak var lNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = UserDefaults.standard.value(forKey: data) as? [String : String] else {return}
        fNameField.text = user[UserKeys.fName]
        lNameField.text = user[UserKeys.lName]
        usernameField.text = user[UserKeys.username]
        idField.text = user[UserKeys.id]
        saveButton.layer.cornerRadius = 8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

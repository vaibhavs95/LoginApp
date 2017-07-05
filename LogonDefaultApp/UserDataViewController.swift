//
//  UserDataViewController.swift
//  LoginDefaultApp
//
//  Created by Vaibhav Singh on 30/06/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController, UITextFieldDelegate {

    var data = String()
    var password = String()
//    var user: [String: String] = [:]

    @IBOutlet weak var firstNameField: UITextField!{
        didSet {firstNameField.delegate = self }
    }
    @IBOutlet weak var lastNameField: UITextField!{
        didSet { lastNameField.delegate = self}
    }
    @IBOutlet weak var usernameField: UITextField!{
        didSet {usernameField.delegate = self}
    }
    @IBOutlet weak var idField: UITextField!{
        didSet {idField.delegate = self}
    }
    @IBOutlet weak var saveButton: UIButton!{
        didSet {
            saveButton.layer.cornerRadius = 15
            saveButton.isEnabled = false
            saveButton.backgroundColor = UIColor.lightGray
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = UserDefaults.standard.value(forKey: data) as? [String : String] else {return}
        firstNameField.text = user[UserKeys.fName]
        lastNameField.text = user[UserKeys.lName]
        usernameField.text = user[UserKeys.username]
        idField.text = user[UserKeys.id]
        password = user[UserKeys.password]!
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        guard let firstName = firstNameField.text,
            let lastName = lastNameField.text,
            let userName = usernameField.text,
            let id = idField.text  else {return}

        if firstName.isEmpty{
            alert(message: "First Name can't be empty!")
            return
        }
        if userName.isEmpty{
            alert(message: "Username Field can't be empty!")
            return
        }
        if id.isEmpty {
            alert(message: "ID can't be empty!")
            return
        } else {
            let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
            if !validation(emailRegex, id){
                alert(message: "Email ID doen't have the correct format")
                return
            }
        }
        if (UserDefaults.standard.value(forKey: id) != nil && id != data){
            alert(message: "User with this Email already exists")
            return
        }
        UserDefaults.standard.removeObject(forKey: data)
        let editedUser = [UserKeys.fName : firstName, UserKeys.lName : lastName, UserKeys.id : id, UserKeys.username : userName, UserKeys.password : password ]
        UserDefaults.standard.set(editedUser, forKey: id)
        alert("Success", message: "Changes saved Successfully")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            usernameField.becomeFirstResponder()
        case usernameField:
            idField.becomeFirstResponder()
        case idField:
            textField.resignFirstResponder()
            if saveButton.isEnabled
                {saveButtonAction(saveButton)}
        default:
            textField.resignFirstResponder()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let user = UserDefaults.standard.value(forKey: data) as? [String : String] else {return false}
        guard let str = textField.text as NSString? else {return false}
        let updatedString = str.replacingCharacters(in: range, with: string)
        switch textField {
        case firstNameField:
            enableOnChange(user[UserKeys.fName], updatedString)
        case lastNameField:
            enableOnChange(user[UserKeys.lName], updatedString)
        case usernameField:
            enableOnChange(user[UserKeys.username], updatedString)
        case idField:
            enableOnChange(user[UserKeys.id], updatedString)
        default:
            saveButton.isEnabled = false
            saveButton.backgroundColor = UIColor.lightGray
        }
        return true
    }

    func enableOnChange(_ stored : String?, _ new : String){
        if stored != new {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor(rgb: 0x007AFF)
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = UIColor.lightGray
        }

    }
}

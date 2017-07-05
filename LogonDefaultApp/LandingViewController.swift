//
//  LandingViewController.swift
//  LoginDefaultApp
//
//  Created by Vaibhav Singh on 30/06/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignupButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.hidesBackButton = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        LoginButton.layer.cornerRadius = 8
        SignupButton.layer.cornerRadius = 8
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

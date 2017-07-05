//
//  LandingViewController.swift
//  LoginDefaultApp
//
//  Created by Vaibhav Singh on 30/06/17.
//  Copyright © 2017 Vaibhav Singh. All rights reserved.
//

import UIKit
import Social

class LandingViewController: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.layer.cornerRadius = 15
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.hidesBackButton = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }

    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["sup"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        //        if let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
        //            vc.setInitialText("Look at this great picture!")
        //            vc.add(imageView.image!)
        //            vc.add(URL(string: "http://www.photolib.noaa.gov/nssl"))
        //            present(vc, animated: true)
        //        }
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
}

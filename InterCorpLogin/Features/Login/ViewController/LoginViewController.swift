//
//  LoginViewController.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 05/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginFacebookButton: FBLoginButton!
    
    private let tag = String(describing: LoginViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginFacebookButton.delegate = self
    }
}


extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            AppLogger.e(tag, "Error when try to login in facebook", error)
            return
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        AppLogger.d(tag, "Log out")
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  LoginViewController.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 05/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginFacebookButton: FBLoginButton!
    @IBOutlet weak var loginView: UIView!

    private let tag = String(describing: LoginViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let token = AccessToken.current?.tokenString {
            showLoader()
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            loginWithFirebase(credential: credential)
        }

        loginView.layer.cornerRadius = 23

        // FacebookLoginButoon
        loginFacebookButton.delegate = self
        loginFacebookButton.permissions = ["email"]
        loginFacebookButton.setAttributedTitle(NSAttributedString(string: "Login with Facebook"), for: .normal)
    }

    private func loginWithFirebase(credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            self.hideLoader()
            if let error = error {
                AppLogger.e(self.tag, "Error when try to login in Firebase", error)
                self.alertView(with: "generic_error".localized())
                return
            }
            self.performSegue(withIdentifier: "formSegue", sender: nil)
        }
    }
}

extension LoginViewController: LoginViewControllerProtocol {

    func showLoader() {
        DispatchQueue.main.async {
            self.loginFacebookButton.isEnabled = false
            self.showSpinner(onView: self.view)
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
            self.loginFacebookButton.isEnabled = true
            self.removeSpinner(view: self.view)
        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            AppLogger.e(tag, "Error when try to login in facebook", error)
            self.alertView(with: "generic_error".localized())
            return
        }

        guard let token = AccessToken.current?.tokenString else {
            return
        }

        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        showLoader()
        loginWithFirebase(credential: credential)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        AppLogger.d(tag, "Log out")
        self.dismiss(animated: true, completion: nil)
    }
}

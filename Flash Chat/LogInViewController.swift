//
//  LogInViewController.swift
//  Flash Chat
//
//  Created by Abdullah Alhaider on 12/14/17.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//


import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    private func setup(){
        emailTextfield.becomeFirstResponder()
    }

    
    func login(){
        SVProgressHUD.show()
        // Logging in the user
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil {
                print(error!)
            }else{
                //Success
                print("\nSign in Successful\n")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
    
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        login()
    }
        
}
    

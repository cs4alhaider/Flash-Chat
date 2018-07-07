//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Abdullah Alhaider on 12/14/17.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

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

    
    func register(){
        SVProgressHUD.show()
        //TODO: Set up a new user on our Firbase database
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user,error) in
            if error != nil {
                print(error!)
            }else{
                //Success
                print("\nRegistrition Successful\n")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
  
    
    @IBAction func registerPressed(_ sender: AnyObject) {
       register()
    } 
    
    
}

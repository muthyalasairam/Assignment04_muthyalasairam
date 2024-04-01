//
//  CreateAccountVC.swift
//  s567075ShopcyApp
//
//  Created by Sai Ram Muthyala on 3/30/24.
//

import UIKit
import FirebaseAuth

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func rePasswordCheck(_ sender: UITextField) {
        guard let password = sender.text else { return }
        if password.count < 6 {
            meessageLBL.text =  "Password must be at least 6 characters long!"
        } else {
            meessageLBL.text = ""
        }
    }
    
    @IBAction func passwordCheck(_ sender: UITextField) {
        guard let password = sender.text else { return }
        if password.count < 6 {
            meessageLBL.text =  "Password must be at least 6 characters long!"
        } else {
            meessageLBL.text = ""
        }
    }
    
    @IBOutlet weak var checkPasswordTF: UITextField!
    
    @IBOutlet weak var registerBTN: UIButton!
    
    @IBAction func createUser(_ sender: UIButton) {
        guard let email = emailTF.text, !email.isEmpty else {
            meessageLBL.text = "Please enter email!"
            return
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            meessageLBL.text =  "Please enter password in both fields!"
            return
        }
        
        guard let checkPassword = checkPasswordTF.text, !checkPassword.isEmpty else {
            meessageLBL.text =  "Please enter password in both fields!"
            return
        }
        
        guard password == checkPassword else {
            meessageLBL.text = "Password should match!"
            return
        }
        
        guard password.count >= 6 else {
            meessageLBL.text = "Password must be at least 6 characters long!"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.meessageLBL.text = "Invalid details"
            } else {
                
                self?.performSegue(withIdentifier: "createAccountToLogin", sender: self)
            }
        }
    }
    
    @IBAction func cancelAccountCreation(_ sender: Any) {
        self.performSegue(withIdentifier: "createAccountToLogin", sender: self)
    }
    @IBOutlet weak var meessageLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
}

//
//  LoginVC.swift
//  s567075ShopcyApp
//
//  Created by Sai Ram Muthyala on 3/30/24.
//

import UIKit
import Lottie
import Firebase

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var loginLav: LottieAnimationView! {
        didSet{
            loginLav.animation = LottieAnimation.named("Shopcy_Login")
            loginLav.alpha = 1
            loginLav.loopMode = .loop
            loginLav.play{ [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]){
                    self?.loginLav.alpha = 0.0
                }
            }
        }
    }
    
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginBTN: UIButton!
    
    @IBAction func onLogin(_ sender: UIButton) {
        guard let email = usernameTF.text, !email.isEmpty else {
            messageLBL.text = "Please enter Username!"
            return
        }
        
        guard let pass = passwordTF.text, !pass.isEmpty else {
            messageLBL.text = "Please enter Password!"
            return
        }
        messageLBL.text = ""
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            if let error = error {
                self?.messageLBL.text = "Invalid Login Credentials! Please try again"
            } else {
                self?.performSegue(withIdentifier: "loginToProducts", sender: self)
            }
        }
        
        
    }
    
}

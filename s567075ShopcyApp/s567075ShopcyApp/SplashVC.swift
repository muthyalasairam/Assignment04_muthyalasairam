//
//  ViewController.swift
//  s567075ShopcyApp
//
//  Created by Sai Ram Muthyala on 3/30/24.
//

import UIKit
import Lottie

class SplashVC: UIViewController {


    @IBOutlet weak var launchLAV: LottieAnimationView! {
        didSet {
            launchLAV.animation = LottieAnimation.named("Shopcy_Launch")
            launchLAV.alpha = 1
            launchLAV.play{ [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]){
                    self?.launchLAV.alpha = 0.0
                    self?.performSegue(withIdentifier: "splashToLogin", sender: self)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


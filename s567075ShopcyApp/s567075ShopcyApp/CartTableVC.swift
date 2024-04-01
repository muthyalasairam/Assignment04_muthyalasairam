//
//  CartTableVC.swift
//  s567075ShopcyApp
//
//  Created by Sai Ram Muthyala on 3/31/24.
//

import UIKit

class CartTableVC: UIViewController {

    @IBOutlet weak var productsTV: UITableView!
    
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var priceLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buyCart(_ sender: UIButton) {
    }
    
    
    @IBAction func clearCart(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

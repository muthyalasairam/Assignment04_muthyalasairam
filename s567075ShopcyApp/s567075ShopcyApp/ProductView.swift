//
//  ProductView.swift
//  s567075ShopcyApp
//
//  Created by Sai Ram Muthyala on 3/30/24.
//

import UIKit

class ProductView: UIView {

    @IBOutlet weak var titleLBL: UILabel!
    
    @IBOutlet weak var descriptionLBL: UILabel!
    
    @IBOutlet weak var ratingLBL: UILabel!
    @IBOutlet weak var discountAndActualPriceLBL: UILabel!
    
    @IBOutlet weak var productIMG: UIImageView!
    
    override init(frame: CGRect){
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }

        private func setupView() {
            let nib = UINib(nibName: "ProductView", bundle: nil)
               if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
                   addSubview(view)
                   view.frame = bounds
                 
               }
            layer.cornerRadius = 5
            layer.borderWidth = 2
            layer.borderColor = UIColor.black.cgColor
        }
}

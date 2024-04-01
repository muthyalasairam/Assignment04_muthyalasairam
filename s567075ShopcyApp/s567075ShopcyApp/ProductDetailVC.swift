//
//  ProductDetailVC.swift
//  s567075ShopcyApp
//
//  Created by Sai Ram Muthyala on 3/31/24.
//

import UIKit

class ProductDetailVC: UIViewController, UIContextMenuInteractionDelegate {
    var selectedProduct: Product?
    var selectedProductKey: String?
    let memoryOptions = ["2TB", "1TB", "512GB", "256GB", "128GB"]
    let colorOptions = ["Blue🟦", "Green🟩", "Red🟥", "Black⬛️", "White⬜️"]
    var selectedMemory: String = ""
    var selectedColor: String = ""

    
    @IBOutlet weak var ratingLBL: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var messsageLBL: UILabel!
    
    @IBOutlet weak var imgIV: UIImageView!
    
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBOutlet weak var imageChangePC: UIPageControl!
    
    @IBOutlet weak var memorySize: UIButton!
    
    
    @IBOutlet weak var itemColors: UIButton!
    
    @IBOutlet weak var cartBTN: UIButton!
    
    @IBAction func addToCart(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var buyBTN: UIButton!
    
    
    @IBAction func buy(_ sender: UIButton) {
    }
    
    
   
    
    @IBAction func logout(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = selectedProduct {
            navigationItem.title = product.title
            descriptionTV.text = product.description
            price.text = "\(product.price)"
            ratingLBL.text = "\(product.rating)"
            
        }
        if let images = selectedProduct?.images, !images.isEmpty {
            imageChangePC.numberOfPages = images.count
            if let img = URL(string: images[0]) {
                imgIV.sd_setImage(with: img, placeholderImage: UIImage(named: "placeholder"))
            }
        }
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        imgIV.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        imgIV.addGestureRecognizer(swipeRight)
        
        imgIV.isUserInteractionEnabled = true
       
        
        memorySize.addInteraction(UIContextMenuInteraction(delegate: self))
        itemColors.addInteraction(UIContextMenuInteraction(delegate: self))
        
    }
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
           let button = interaction.view as! UIButton
           
           if button == memorySize {
               return createContextMenu(title: "Memory", options: memoryOptions, defaultOption: memoryOptions.first)
           } else if button == itemColors {
               return createContextMenu(title: "Color", options: colorOptions, defaultOption: colorOptions.first)
           }
           
           return nil
       }

       // MARK: - Helper Methods

       func createContextMenu(title: String, options: [String], defaultOption: String?) -> UIContextMenuConfiguration {
           let menuActions = options.map { option in
               let state: UIMenuElement.State = option == defaultOption ? .on : .off
               return UIAction(title: option, state: state) { [weak self] _ in
                   if title == "Memory" {
                       self?.selectedMemory = option
                       self?.memorySize.setTitle(option, for: .normal)
                   } else if title == "Color" {
                       self?.selectedColor = option
                       self?.itemColors.setTitle(option, for: .normal)
                   }
               }
           }

           return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
               UIMenu(title: title, children: menuActions)
           }
       }

    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let img = selectedProduct?.images else {
            return
        }
        var pageControl = imageChangePC.currentPage
        
        if gesture.direction == .left {
            pageControl += 1
            if pageControl >= img.count {
                pageControl = 0
            }
        }
        else if gesture.direction == .right {
            pageControl -= 1
            if pageControl < 0 {
                pageControl = img.count - 1
            }
        }
        imageChangePC.currentPage = pageControl
        if let imageURL = URL(string: img[pageControl]) {
            imgIV.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
}

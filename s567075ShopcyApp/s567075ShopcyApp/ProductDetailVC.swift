//
//  ProductDetailVC.swift
//  s567075ShopcyApp
//
//  Created by Sai Ram Muthyala on 3/31/24.
//

import UIKit

class ProductDetailVC: UIViewController, UIEditMenuInteractionDelegate {
    var selectedProduct: Product?
    var selectedProductKey: String?
    let memoryOptions = ["2TB", "1TB", "512GB", "256GB", "128GB"]
    let colorOptions = ["Blue🟦", "Green🟩", "Red🟥", "Black⬛️", "White⬜️"]
    
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

        // Set default memory size
               memorySize.setTitle(memoryOptions.first, for: .normal)

               // Add edit menu interaction to memorySize button
               let editMenuInteraction = UIEditMenuInteraction(delegate: self)
               memorySize.addInteraction(editMenuInteraction)
           }

           // Handle edit menu interaction
           override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
               if action == #selector(showMemorySizeOptions) {
                   return true
               }
               return super.canPerformAction(action, withSender: sender)
           }

           @objc func showMemorySizeOptions() {
               // Create UIMenu
               let menu = UIMenu(title: "Select Memory Size", children: memorySizeOptions())

               // Show UIMenu
               let menuController = UIMenuController.shared
               menuController.showMenu(from: view, rect: memorySize.frame)
           }

           // Define memory size options
           private func memorySizeOptions() -> [UIMenuElement] {
               var menuItems: [UIMenuElement] = []
               for size in memoryOptions {
                   let action = UIAction(title: size, handler: { [weak self] _ in
                       self?.memorySize.setTitle(size, for: .normal)
                       // Handle selection here, e.g., update selected product
                   })
                   menuItems.append(action)
               }
               return menuItems
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

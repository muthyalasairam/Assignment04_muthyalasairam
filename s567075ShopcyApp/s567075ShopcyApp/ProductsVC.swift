//
//  ProductsVC.swift
//  s567075ShopcyApp
//
//  Created by Sai Ram Muthyala on 3/31/24.
//

import UIKit
import SDWebImage
class ProductsVC: UIViewController {
    
    var key = "shopcy_product_"
    var product: Product?
    @IBOutlet var productViewCLCTN: [ProductView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await fetchProductsAndUpdateViews()
        }
        for productView in productViewCLCTN {
                   let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
                   longPressGesture.minimumPressDuration = 0.5
                   productView.addGestureRecognizer(longPressGesture)
               }
    }
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
           if gestureRecognizer.state == .began {
               guard let productView = gestureRecognizer.view as? ProductView else { return }
               guard let selectedIndex = productViewCLCTN.firstIndex(of: productView) else { return }
               key = "shopcy_product_\(selectedIndex + 1)"
               product = FireStoreOperations.products[key]
               navigateToProductDetailsView()
           }
       }
    func navigateToProductDetailsView() {
           performSegue(withIdentifier: "productDetail", sender: self)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destinationVC = segue.destination as? ProductDetailVC,
           let selectedProduct = product {
            destinationVC.selectedProduct = selectedProduct
            destinationVC.selectedProductKey = key
        }
    }
    private func fetchProductsAndUpdateViews() async {
        await FireStoreOperations.fetchProducts()
        var i = 0
        for productView in productViewCLCTN {
            i = i+1
            guard let product = FireStoreOperations.products["\(key)\(i)"] else { continue }
     
            updateProductView(productView, with: product)
        }
    }
    private func updateProductView(_ productView: ProductView, with product: Product) {
        productView.titleLBL.text = product.title
        productView.descriptionLBL.text = product.description
        productView.ratingLBL.text = "Rating: \(product.rating)"
        let discountPrice = product.price - (product.price * product.discountPercentage / 100.0)
        productView.discountAndActualPriceLBL.text = "$\(discountPrice)/$\(product.price)"
        if let url = URL(string: product.thumbnail) {
            print("url\(url)")
            productView.productIMG.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
    }
    
}


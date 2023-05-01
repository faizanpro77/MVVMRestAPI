//
//  ProductCell.swift
//  MVVMRestAPI
//
//  Created by MD Faizan on 01/05/23.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productBackgroundView: UIView!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productCategoryLabel: UILabel!
    
    @IBOutlet weak var rateButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var product:Product? {
        didSet { //property Observer
            productDetailsConfiguration()
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //UI related part we can do here
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15
        productImageView.layer.cornerRadius = 10
        self.productBackgroundView.backgroundColor = .systemGray6
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func productDetailsConfiguration() {
        guard let product = product else {
            return
        }
        
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
}

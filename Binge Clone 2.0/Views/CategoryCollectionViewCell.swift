//
//  CategoryCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryBackgroundView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    static let identifier = "CategoryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    private func setupView() {
        categoryBackgroundView.layer.cornerRadius = 5
        categoryImageView.layer.cornerRadius = 5
        categoryBackgroundView.backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1) //white
    }
    
    func setup( image: String) {
        categoryImageView.image = UIImage(named: image)
    }

}


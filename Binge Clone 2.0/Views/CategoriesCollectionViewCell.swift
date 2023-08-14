//
//  CategoriesCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryBackgroundView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    static let identifier = "CategoriesCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    private func setupView() {
        categoryBackgroundView.layer.cornerRadius = categoryLabel.frame.height / 2
        categoryBackgroundView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    func setup( label: String) {
        categoryLabel.text = label
    }
    
}


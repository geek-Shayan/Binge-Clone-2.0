//
//  NoResultCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class NoResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var noResultBackgroundView: UIView!
    @IBOutlet weak var noResultImageView: UIImageView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    static let identifier = "NoResultCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupView()
    }
    private func setupView() {
        noResultBackgroundView.layer.cornerRadius = 8
    }
    
    func setup( label: String) {
        noResultLabel.text = label
        
    }
}

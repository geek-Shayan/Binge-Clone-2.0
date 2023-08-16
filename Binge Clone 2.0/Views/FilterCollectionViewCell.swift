//
//  FilterCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filterBackgroundView: UIView!
    
    @IBOutlet weak var filterImage: UIImageView!
    
    @IBOutlet weak var filterLabel: UILabel!
    
    static let identifier = "FilterCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupView()
        
    }
    
    private func setupView() {
        filterBackgroundView.layer.borderWidth = 1
        filterBackgroundView.layer.cornerRadius = 10
        filterBackgroundView.backgroundColor = .black
        filterBackgroundView.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor  //gray
        
        filterImage.isHidden = false
    }
    
    func selected() {
        filterBackgroundView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) //gray
        filterBackgroundView.layer.borderWidth = 0
        
        filterImage.isHidden = false
    }
    
    func deSelected() {
        filterBackgroundView.backgroundColor = .black
        filterBackgroundView.layer.borderWidth = 1
        
        filterImage.isHidden = true
    }

    
    func setup(label: String) {
        filterLabel.text = label
    }
}

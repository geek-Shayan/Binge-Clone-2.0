//
//  TVCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class TVCollectionViewCell: UICollectionViewCell {

    static let identifier = "TVCollectionViewCell"
    
    @IBOutlet weak var TVBackgroundView: UIView!
    
    @IBOutlet weak var TVBackgroundImage: UIImageView!
    
    @IBOutlet weak var TVImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setup(image: String, label: String? = nil) {
        TVImage.image = UIImage(named: image)
//        myLabel.text = label
    }
}

//
//  HeaderCollectionReusableView.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var headerBackgroundView: UIView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var header: UILabel!
    
    static let headerIdentifier = "HeaderCollectionReusableView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(head: String, font: UIFont = .systemFont(ofSize: 14, weight: .bold), imageFlag: Bool = false) {
        header.text = head
        header.font = font
        imageFlag ? (image.isHidden = false) : (image.isHidden = true)
    }
    
}

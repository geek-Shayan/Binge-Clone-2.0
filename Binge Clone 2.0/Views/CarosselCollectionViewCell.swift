//
//  CarosselCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class CarosselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var carosselBackgroundView: UIView!
    
    @IBOutlet weak var carosselImageView: UIImageView!
    
    @IBOutlet weak var carosselTopGradientImageView: UIImageView!
    
    @IBOutlet weak var carosselBottomGradientImageView: UIImageView!
    
    @IBOutlet weak var carosselPageControl: UIPageControl!
    
    static let identifier = "CarosselCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    private func setupView() {
//        carosselBackgroundView.backgroundColor = .red
        carosselPageControl.currentPage = 0
    }
    
    func setup(image: String, indexPath: IndexPath, dataSize: Int) {
        carosselImageView.image = UIImage(named: image)
        carosselPageControl.currentPage = indexPath.item
        carosselPageControl.numberOfPages = dataSize
    }
}

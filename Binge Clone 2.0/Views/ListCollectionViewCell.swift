//
//  ListCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var listBackgroundView: UIView!
    
    @IBOutlet weak var listImage: UIImageView!
    
    @IBOutlet weak var listLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    static let identifier = "ListCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    private func setupView() {
        listBackgroundView.layer.cornerRadius = 10
        listBackgroundView.layer.borderWidth = 2
        listBackgroundView.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        
        listImage.layer.cornerRadius = 5

    }

    func setup(image: String, title: String, progress: Float = 0.0, hideProgress: Bool = false , duration: String) {
        listImage.image = UIImage(named: image)
        listLabel.text = title
        durationLabel.text = duration

        if hideProgress {
            progressView.isHidden = true
        }
        else {
            progressView.isHidden = false
            progressView.progress = progress
        }
    }

}


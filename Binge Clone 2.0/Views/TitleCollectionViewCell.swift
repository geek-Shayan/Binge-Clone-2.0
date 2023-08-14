//
//  TitleCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleBackgroundView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!

    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    static let identifier = "TitleCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    private func setupView() {
        titleBackgroundView.layer.cornerRadius = 5
//        titleBackgroundView.backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1) //white
    }
    
    func setup(title: String, year: String, genre: String, duration: String) {
        titleLabel.text = title
        yearLabel.text = year
        genreLabel.text = genre
        durationLabel.text = duration
    }

}


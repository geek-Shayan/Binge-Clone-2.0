//
//  GenreCollectionViewCell.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreBackgroundView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    
    static let identifier = "GenreCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    private func setupView() {
        genreBackgroundView.layer.cornerRadius = genreLabel.frame.height / 2
    }
    
    func selected() {
        genreBackgroundView.backgroundColor = UIColor(red: 0.9, green: 0.04, blue: 0.08, alpha: 1) //red
    }
    
    func deSelected() {
        genreBackgroundView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    func setup( label: String) {
        genreLabel.text = label
    }

    
}

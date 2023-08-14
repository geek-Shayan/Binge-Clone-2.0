//
//  FooterCollectionReusableView.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    
    static let footerIdentifier = "footer"
    
    @IBOutlet weak var footer: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
    }
    
    func setup(foot: String, indicatorFlag: Bool = false) {
        footer.text = foot
        indicatorFlag ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
}

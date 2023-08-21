//
//  FooterWithPagerCollectionReusableView.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 20/8/23.
//

import UIKit

class FooterWithPagerCollectionReusableView: UICollectionReusableView {

    static let footerIdentifier = "footerWithPager"
        
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }

    private func setupView() {
        pageControl.currentPage = 0
    }
    
    func setup(indexPath: IndexPath, dataSize: Int) {
        pageControl.currentPage = indexPath.item
        pageControl.numberOfPages = dataSize
    }
}

//
//  UICollectionView+Extension.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 21/8/23.
//

import UIKit


// MARK: Custom UICollectionView auto scroll to header extension

extension UICollectionView {
    func scrollToSupplementaryView(ofKind kind: String, at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool, navigationOffset: CGFloat) {
        self.layoutIfNeeded();
        if let layoutAttributes =  self.layoutAttributesForSupplementaryElement(ofKind: kind, at: indexPath) {
            let viewOrigin = CGPoint(x: layoutAttributes.frame.origin.x, y: layoutAttributes.frame.origin.y);
            var offset : CGPoint = self.contentOffset;
            
            switch(scrollPosition) {
            case UICollectionView.ScrollPosition.top:
                offset.y = viewOrigin.y - self.contentInset.top - (2 * navigationOffset) //- 190// -190 for navigation componsation at top
                
            case UICollectionView.ScrollPosition.left:
                offset.x = viewOrigin.x - self.contentInset.left
                
            case UICollectionView.ScrollPosition.right:
                offset.x = (viewOrigin.x - self.contentInset.left) - (self.frame.size.width - layoutAttributes.frame.size.width)
                
            case UICollectionView.ScrollPosition.bottom:
                offset.y = (viewOrigin.y - self.contentInset.top) - (self.frame.size.height - layoutAttributes.frame.size.height)
                
            case UICollectionView.ScrollPosition.centeredVertically:
                offset.y = (viewOrigin.y - self.contentInset.top) -  (self.frame.size.height / 2 - layoutAttributes.frame.size.height / 2)
                
            case UICollectionView.ScrollPosition.centeredHorizontally:
                offset.x = (viewOrigin.x - self.contentInset.left) -  (self.frame.size.width / 2 - layoutAttributes.frame.size.width / 2)
            default:
                break
            }
            self.scrollRectToVisible(CGRect(origin: offset, size: self.frame.size), animated: animated)
        }
    }
}


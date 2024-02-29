//
//  AppLayouts.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 22/8/23.
//

import UIKit


class AppLayouts {
    static let shared = AppLayouts()
    
    private init() { }
    
    func createCarosselSection() -> NSCollectionLayoutSection {
        print("first carossel")
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        //                item.contentInsets.trailing = 2
        //                item.contentInsets.bottom = 8
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(10))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: SupplementraryHeaderFooter.headerElementKind, alignment: .topLeading)
        let footerWithPager = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: SupplementraryHeaderFooter.footerElementWithPagerKind, alignment: .bottomLeading)
        section.boundarySupplementaryItems = [footerWithPager] //, footer
        
        section.visibleItemsInvalidationHandler = { (items, scrollOffset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - scrollOffset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0 - (distanceFromCenter / environment.container.contentSize.width)
                let scale = max(maxScale, minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return section
    }
    
    
    func createSecondSection() -> NSCollectionLayoutSection {
        print("second")
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 16
        item.contentInsets.bottom = 8
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(150)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets.leading = 16
        
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: SupplementraryHeaderFooter.headerElementKind, alignment: .topLeading)
//                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: footerKind, alignment: .bottomLeading)
        section.boundarySupplementaryItems = [header] //, footer
        
        return section
    }
}

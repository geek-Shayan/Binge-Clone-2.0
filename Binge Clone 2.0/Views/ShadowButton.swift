//
//  ShadowButton.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 8/8/23.
//

import UIKit

class ShadowButton: UIButton {

    private let topShadowLayer = CALayer()
    private let bottomShadowLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupShadowLayers()
    }
    
    private func setupShadowLayers() {
        
//        topShadowLayer.backgroundColor = UIColor.clear.cgColor
//        bottomShadowLayer.backgroundColor =  UIColor.clear.cgColor
        
        layer.addSublayer(topShadowLayer)
        layer.addSublayer(bottomShadowLayer)
        
        layer.cornerRadius = 10
        
        updateShadowLayers()
    }
    
    private func updateShadowLayers() {
        let shadowColor = UIColor.black.cgColor
        let shadowOffset = CGSize(width: 0, height: 2)
        let shadowOpacity: Float = 1.0
        let shadowRadius: CGFloat = 4
        let cornerRadius: CGFloat = 1
        let topShadowPath = UIBezierPath(roundedRect: topShadowLayer.bounds, cornerRadius: cornerRadius)
        let bottomShadowPath = UIBezierPath(roundedRect: bottomShadowLayer.bounds, cornerRadius: cornerRadius)
        
//        topShadowLayer.position = center
        topShadowLayer.shadowColor = shadowColor
        topShadowLayer.shadowOffset = shadowOffset
        topShadowLayer.shadowOpacity = shadowOpacity
        topShadowLayer.shadowRadius = shadowRadius
        topShadowLayer.shadowPath = topShadowPath.cgPath
        
//        bottomShadowLayer.position = center
        bottomShadowLayer.shadowColor = shadowColor
        bottomShadowLayer.shadowOffset = shadowOffset
        bottomShadowLayer.shadowOpacity = shadowOpacity
        bottomShadowLayer.shadowRadius = shadowRadius
        bottomShadowLayer.shadowPath = bottomShadowPath.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowLayers()
        
        topShadowLayer.frame = CGRect(x: 4, y: 0, width: bounds.width - 8, height: 2)
        bottomShadowLayer.frame = CGRect(x: 2, y: bounds.height , width: bounds.width - 4, height: 2)
    }
    
    func disabled() {
        layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
        isUserInteractionEnabled = false
    }
    
    func enabled() {
        layer.backgroundColor = UIColor(red: 0.91, green: 0.204, blue: 0.192, alpha: 1).cgColor // red
        isUserInteractionEnabled = true
    }
    
}

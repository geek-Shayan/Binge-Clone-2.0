//
//  BasicTextField.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 8/8/23.
//

import UIKit

class BasicTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
    }
    
    private func setupLayers() {
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor // white
//        backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1) // gray
        addPadding(padding: .equalSpacing(14))
    }
}

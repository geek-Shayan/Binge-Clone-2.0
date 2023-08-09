//
//  DOBTextField.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 8/8/23.
//

import UIKit

class DOBTextField: UITextField {
    
    private let datePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
        createDatePicker()
    }
    
    private func setupLayers() {
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor // white
//        backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1) // gray
        addPadding(padding: .equalSpacing(14))
        
        dateFormatter.dateStyle = .medium
//        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeStyle = .none
    }
    
    private func createToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelPressed))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelBtn, flexibleBtn, doneBtn], animated: true)
        
        return toolBar
        
    }

    private func createDatePicker() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        
        inputView = datePicker
//        inputAccessoryView = createToolbar()
        datePicker.addTarget(self, action: #selector(dateSelected(datePicker:)), for: .valueChanged)
    }
    
    @objc func dateSelected(datePicker: UIDatePicker) {
        text = dateFormatter.string(from: datePicker.date)
//        endEditing(true)
    }
    
    @objc func cancelPressed() {
        text = nil
        endEditing(true)
    }
    
    @objc func donePressed() {
        text = dateFormatter.string(from: datePicker.date)
        endEditing(true)
    }
}

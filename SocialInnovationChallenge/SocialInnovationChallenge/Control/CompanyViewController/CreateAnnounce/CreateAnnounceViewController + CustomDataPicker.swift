//
//  CreateAnnounceViewController + CustomDataPicker.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 08/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//
import UIKit

extension CreateAnnounceViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selecteData = dataPicker[row]
        workdayTextField.text = selecteData
    }
    //what is the difference between internal enad private?
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 22)
        label.text = dataPicker[row]
        
        return label
    }
    
        func createToolBar() {
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            
    //        toolBar.barTintColor = .black
    //        toolBar.tintColor = .red
            
            let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(CreateAnnounceViewController.dismissKeyboard))
            
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            workdayTextField.inputAccessoryView = toolBar
        }
}

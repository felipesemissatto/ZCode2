//
//  CreateDataPicker.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 08/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation
import UIKit

class CreateDataPicker {
    
//  Func cria lista picker
    func createPicker(category: UITextField, delegate: UIPickerViewDelegate?)  {
        let picker = UIPickerView()
        picker.delegate = delegate
        category.inputView = picker
           
//        Edit Color
//        picker.backgroundColor = .white
    }

//  Func cria tool bar
    func createToolBar(category: UITextField, viewController: UIViewController) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
    
        let doneButton = UIBarButtonItem(title: "OK",
                                         style: .plain,
                                         target: self,
                                         action: #selector(viewController.dismissKeyboard))
    
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        category.inputAccessoryView = toolBar
        
//        Edit color
//        toolBar.barTintColor = .black
//        toolBar.tintColor = .red
    }
}

//
//  optionTextSlide.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 15/02/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class optionTextSlide: UIView {

    //MARK: Properties
    @IBOutlet weak var customText: UILabel!
    @IBOutlet weak var customText2: UILabel!
    @IBOutlet weak var optionText: UISwitch!
    @IBOutlet weak var topDownSelector: UISegmentedControl!
    @IBOutlet weak var leftRightSelector: UISegmentedControl!
    @IBOutlet weak var blackWhiteSelector: UISegmentedControl!
    @IBOutlet weak var textContentSpace: UITextField!
    @IBOutlet weak var changeText: UIButton!
    
    
    //MARK: Actions
    // this action method active or desactive option text space.
    @IBAction func optionTextAction(_ sender: UISwitch) {
        if sender.isOn == true {
            customText.isHidden = false
            customText.layer.zPosition = 1
            
        } else {
            customText.isHidden = true
            customText2.isHidden = true
        }
    }
    
    // this action method allow custom text disposition.
    @IBAction func topDownSelectorAction(_ sender: UISegmentedControl) {
        if topDownSelector.selectedSegmentIndex == 0 {
            customText2.isHidden = false
            customText.isHidden = true
            customText2.layer.zPosition = 1
        } else if topDownSelector.selectedSegmentIndex == 1 {
            customText2.isHidden = true
            customText.isHidden = false
            customText.layer.zPosition = 1
        }
    }
    
    // this action method allow custom text disposition.
    @IBAction func leftRightSelectorAction(_ sender: UISegmentedControl) {
        if leftRightSelector.selectedSegmentIndex == 0 {
            customText.textAlignment = .left
            customText2.textAlignment = .left
        } else if leftRightSelector.selectedSegmentIndex == 1 {
            customText.textAlignment = .right
            customText2.textAlignment = .right
        }
    }
    
    // this action method allow custom text color.
    @IBAction func blackWhiteSelectorAction(_ sender: UISegmentedControl) {
        if blackWhiteSelector.selectedSegmentIndex == 0 {
            customText.textColor = UIColor.black
            customText2.textColor = UIColor.black
        } else if blackWhiteSelector.selectedSegmentIndex == 1 {
            customText.textColor = UIColor.white
            customText2.textColor = UIColor.white
        }
    }
    
    // this action method allow custom text content.
    @IBAction func changeTextAction(_ sender: UIButton) {
        
        customText.text = textContentSpace.text
        customText2.text = textContentSpace.text
        textContentSpace.endEditing(true)
        
    }
    
}

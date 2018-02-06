//
//  SecondViewController.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 19/01/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var blurViewLeft: UIVisualEffectView!
    @IBOutlet weak var slideViewLeft: UIView!
    @IBOutlet weak var optionText: UISwitch!
    @IBOutlet weak var textPositionLabel: UILabel!
    @IBOutlet weak var topDownSelector: UISegmentedControl!
    @IBOutlet weak var leftRightSelector: UISegmentedControl!
    @IBOutlet weak var textColorLabel: UILabel!
    @IBOutlet weak var blackWhiteSelector: UISegmentedControl!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var textContentSpace: UITextField!
    @IBOutlet weak var changeText: UIButton!
    
    let viewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // these property concern slide allows to choose option text, must not appear when app is launched
        blurViewLeft.layer.cornerRadius = 15
        var translationTransformLeft: CGAffineTransform
        translationTransformLeft = CGAffineTransform(translationX: -250, y: 0)
        self.slideViewLeft.transform = translationTransformLeft
        
        // These lines will allow you to hide or set up the initial configuration of the different options for the text.
        topDownSelector.selectedSegmentIndex = 1
        leftRightSelector.selectedSegmentIndex = 1
        blackWhiteSelector.selectedSegmentIndex = 1
        viewController.customText.isHidden = true
        viewController.customText2.isHidden = true
        textPositionLabel.isHidden = true
        topDownSelector.isHidden = true
        leftRightSelector.isHidden = true
        textColorLabel.isHidden = true
        blackWhiteSelector.isHidden = true
        textContentLabel.isHidden = true
        textContentSpace.isHidden = true
        changeText.isHidden = true
    }

    
    // this action method active or desactive option text space.
    @IBAction func optionTextAction(_ sender: Any) {
        if optionText.isOn == true {
            viewController.customText.isHidden = false
            viewController.customText.layer.zPosition = 1
            textPositionLabel.isHidden = false
            topDownSelector.isHidden = false
            leftRightSelector.isHidden = false
            textColorLabel.isHidden = false
            blackWhiteSelector.isHidden = false
            textContentLabel.isHidden = false
            textContentSpace.isHidden = false
            changeText.isHidden = false
            
        } else {
            viewController.customText.isHidden = true
            viewController.customText2.isHidden = true
            textPositionLabel.isHidden = true
            topDownSelector.isHidden = true
            leftRightSelector.isHidden = true
            textColorLabel.isHidden = true
            blackWhiteSelector.isHidden = true
            textContentLabel.isHidden = true
            textContentSpace.isHidden = true
            changeText.isHidden = true
        }
    }
    
    // this action method allow custom text disposition.
    @IBAction func topDownSelectorAction(_ sender: UISegmentedControl) {
        if topDownSelector.selectedSegmentIndex == 0 {
            viewController.customText2.isHidden = false
            viewController.customText.isHidden = true
            viewController.customText2.layer.zPosition = 1
        } else if topDownSelector.selectedSegmentIndex == 1 {
            viewController.customText2.isHidden = true
            viewController.customText.isHidden = false
            viewController.customText.layer.zPosition = 1
        }
    }
    
    // this action method allow custom text disposition.
    @IBAction func leftRightSelectorAction(_ sender: UISegmentedControl) {
        if leftRightSelector.selectedSegmentIndex == 0 {
            viewController.customText.textAlignment = .left
            viewController.customText2.textAlignment = .left
        } else if leftRightSelector.selectedSegmentIndex == 1 {
            viewController.customText.textAlignment = .right
            viewController.customText2.textAlignment = .right
        }
    }
    
    // this action method allow custom text color.
    @IBAction func blackWhiteSelectorAction(_ sender: UISegmentedControl) {
        if blackWhiteSelector.selectedSegmentIndex == 0 {
            viewController.customText.textColor = UIColor.black
            viewController.customText2.textColor = UIColor.black
        } else if blackWhiteSelector.selectedSegmentIndex == 1 {
            viewController.customText.textColor = UIColor.white
            viewController.customText2.textColor = UIColor.white
        }
    }
    
    // this action method allow custom text content.
    @IBAction func changeTextAction(_ sender: UIButton) {
        
        viewController.customText.text = textContentSpace.text
        viewController.customText2.text = textContentSpace.text
        textContentSpace.endEditing(true)
        
    }
}

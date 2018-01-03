//
//  ViewController.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 30/11/2017.
//  Copyright © 2017 Mattkee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        displayImageView()
        
    }
    
    deinit {
        //3
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func deviceOrientationDidChange() {
        //2
        switch UIDevice.current.orientation {
        case .faceDown:
            print("Face down")
        case .faceUp:
            print("Face up")
        case .unknown:
            print("Unknown")
        case .landscapeLeft:
            print("Landscape left")
            textLabel.text = "Swipe Left to share"
        case .landscapeRight:
            textLabel.text = "Swipe Left to share"
        case .portrait:
            textLabel.text = "Swipe up to share"
        case .portraitUpsideDown:
            print("Portrait upside down")
        }
    }
    
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    func displayImageView(){
        
        let view1 = UIImageView(image: #imageLiteral(resourceName: "croixbleu"))
        shareView.addSubview(view1)
        
        let view2 = UIImageView(image: #imageLiteral(resourceName: "croixbleu"))
        shareView.addSubview(view2)
        
        let view3 = UIImageView(image: #imageLiteral(resourceName: "recbleu"))
        shareView.addSubview(view3)
        
        
        let tabView = [view1,view2]
        
        
        let stackView = UIStackView(arrangedSubviews: tabView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let princView = [stackView,view3]
        
        let stackViewSecond = UIStackView(arrangedSubviews: princView)
        stackViewSecond.axis = .vertical
        stackViewSecond.distribution = .fillEqually
        stackViewSecond.alignment = .fill
        stackViewSecond.spacing = 8
        stackViewSecond.translatesAutoresizingMaskIntoConstraints = false
        shareView.addSubview(stackViewSecond)
        let secondViewsDictionary = ["stackViewSecond":stackViewSecond]
        let stackViewSecond_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[stackViewSecond]-10-|",  //horizontal constraint 10 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: secondViewsDictionary)
        let stackViewSecond_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[stackViewSecond]-10-|", //vertical constraint 10 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: secondViewsDictionary)
        shareView.addConstraints(stackViewSecond_H)
        shareView.addConstraints(stackViewSecond_V)
        
    }
    
}


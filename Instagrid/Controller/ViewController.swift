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
        
        let view1 = UIStackView(frame: CGRect(x: 0, y: 0, width: shareView.frame.width, height: shareView.frame.height))
        shareView.addSubview(view1)
        
        
        let viewcontent = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        viewcontent.backgroundColor = UIColor.cyan
        view1.addSubview(viewcontent)
        
        let viewcontent1 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        viewcontent1.backgroundColor = UIColor.green
        view1.addSubview(viewcontent1)
        
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
    
    
    
}


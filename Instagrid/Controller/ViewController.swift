//
//  ViewController.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 30/11/2017.
//  Copyright © 2017 Mattkee. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    var modifiedImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        disposition2()
        
        let swipeAnime = UIPanGestureRecognizer(target: self, action: #selector(shareContentAnime(gesture :)))
        actionShareView.addGestureRecognizer(swipeAnime)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(shareContent(gesture:)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(shareContent(gesture:)))
        
        
        swipeLeft.direction = .left
        swipeUp.direction = .up
        
        
        actionShareView.addGestureRecognizer(swipeUp)
        actionShareView.addGestureRecognizer(swipeLeft)
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
    
    @IBOutlet weak var actionShareView: UIView!
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    var modifiedButton : UIButton!
    
    @objc func modifiedButtonBackground (sender : UIButton) {
        modifiedButton = sender
        openPhotoLibraryButton(sender: modifiedButton)
    }
    
    @IBAction func button1selec(_ sender: Any) {
        button1.isSelected = true
        button2.isSelected = false
        button3.isSelected = false
        button1.setImage(#imageLiteral(resourceName: "Carre1Selec"), for: .selected)
        disposition1()
    }
    
    @IBAction func button2selec(_ sender: Any) {
        button1.isSelected = false
        button2.isSelected = true
        button3.isSelected = false
        button2.setImage(#imageLiteral(resourceName: "Carre2Selec"), for: .selected)
        disposition2()
    }
    
    @IBAction func button3selec(_ sender: Any) {
        button1.isSelected = false
        button2.isSelected = false
        button3.isSelected = true
        button3.setImage(#imageLiteral(resourceName: "Carre3Selec"), for: .selected)
        disposition3()
    }
    let view1 = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let view2 = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let view3 = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let view4 = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    func launchAction(sender : UIButton) {
        sender.addTarget(self, action: #selector(modifiedButtonBackground(sender:)), for: .touchUpInside)
    }
    
    func defineStackView (viewArray : [UIView], axe : UILayoutConstraintAxis) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: viewArray)
        stackView.axis = axe
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }
    
    func stackViewContraint (stackView : UIStackView) {
        
        let ViewsDictionary = ["stackView": stackView]
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[stackView]-10-|",  //horizontal constraint 10 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ViewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[stackView]-10-|", //vertical constraint 10 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: ViewsDictionary)
        shareView.addConstraints(stackView_H)
        shareView.addConstraints(stackView_V)
    }
    
    func disposition1(){
        view4.isHidden = true
        
        view1.setBackgroundImage(#imageLiteral(resourceName: "croixbleu"), for: .normal)
        shareView.addSubview(view1)
        launchAction(sender: view1)
        
        view2.setBackgroundImage(#imageLiteral(resourceName: "croixbleu"), for: .normal)
        launchAction(sender: view2)
        shareView.addSubview(view2)
        
        view3.setBackgroundImage(#imageLiteral(resourceName: "recbleu"), for: .normal)
        launchAction(sender: view3)
        shareView.addSubview(view3)
        
        let tabView = [view1,view2]
        
        let tabViewStackView = defineStackView(viewArray: tabView, axe : .horizontal)
        
        
        let princView = [view3, tabViewStackView]
        
        let stackViewSecond = defineStackView(viewArray: princView, axe : .vertical)
        
        shareView.addSubview(stackViewSecond)
        
        stackViewContraint(stackView: stackViewSecond)
        
    }
    
    func disposition2(){
        view4.isHidden = true
        
        view1.setBackgroundImage(#imageLiteral(resourceName: "croixbleu"), for: .normal)
        shareView.addSubview(view1)
        launchAction(sender: view1)
        
        view2.setBackgroundImage(#imageLiteral(resourceName: "croixbleu"), for: .normal)
        launchAction(sender: view2)
        shareView.addSubview(view2)
        
        view3.setBackgroundImage(#imageLiteral(resourceName: "recbleu"), for: .normal)
        launchAction(sender: view3)
        shareView.addSubview(view3)
        
        
        let tabView = [view1,view2]
        
        let tabViewStackView = defineStackView(viewArray: tabView, axe : .horizontal)
        
        
        let princView = [tabViewStackView,view3]
        
        let stackViewSecond = defineStackView(viewArray: princView, axe : .vertical)
        
        shareView.addSubview(stackViewSecond)
        
        stackViewContraint(stackView: stackViewSecond)
        
    }
    
    func disposition3(){
        view4.isHidden = false
        
        view1.setBackgroundImage(#imageLiteral(resourceName: "croixbleu"), for: .normal)
        shareView.addSubview(view1)
        launchAction(sender: view1)
        
        view2.setBackgroundImage(#imageLiteral(resourceName: "croixbleu"), for: .normal)
        launchAction(sender: view2)
        shareView.addSubview(view2)
        
        view3.setBackgroundImage(#imageLiteral(resourceName: "croixbleu"), for: .normal)
        launchAction(sender: view3)
        shareView.addSubview(view3)
        
        view4.setBackgroundImage(#imageLiteral(resourceName: "croixbleu"), for: .normal)
        launchAction(sender: view4)
        shareView.addSubview(view4)
        
        
        let tabView = [view1,view2]
        let tabView2 = [view3,view4]
        
        let tabViewStackView = defineStackView(viewArray: tabView, axe : .horizontal)
        
        let tabView2StackView = defineStackView(viewArray:tabView2, axe : .horizontal)
        
        
        let princView = [tabViewStackView,tabView2StackView]
        
        let stackViewSecond = defineStackView(viewArray: princView, axe : .vertical)
        
        shareView.addSubview(stackViewSecond)
        
        stackViewContraint(stackView: stackViewSecond)
        
    }
    @objc func openCameraButton(sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func openPhotoLibraryButton(sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        modifiedButton.setBackgroundImage(image, for: .normal)
        
        dismiss(animated:true, completion: nil)
    }
    
    @objc func shareContentAnime(gesture : UIPanGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            switch UIDevice.current.orientation {
                case .portrait :
                    let translation = gesture.translation(in: actionShareView)
                    
                    if translation.y < 0 {
                        transformShareContentViewWith(gesture: gesture)
                    }
                case .landscapeLeft, .landscapeRight :
                    let translation = gesture.translation(in: actionShareView)
                    
                    if translation.x < 0 {
                        transformShareContentViewWith(gesture: gesture)
                    }
            default :
                    transformShareContentViewWith(gesture: gesture)
                }
        case .ended, .cancelled :
            actionShareView.transform = .identity
            //share()
        default:
            break
        }
    }
    
    @objc func shareContent(gesture : UISwipeGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            print("c'est bon ici")
        case .ended, .cancelled :
            print ("c'est fini")
            share()
        default:
            break
        }
    }
    func transformShareContentViewWith(gesture: UIPanGestureRecognizer){
        
        switch UIDevice.current.orientation {
            case .portrait :
                let translation = gesture.translation(in: actionShareView)
                
                if translation.y < 0 {
                    let transform = CGAffineTransform(translationX: 0, y: translation.y)
                    actionShareView.transform = transform
                }
            case .landscapeLeft, .landscapeRight :
                let translation = gesture.translation(in: actionShareView)
                
                if translation.x < 0 {
                    let transform = CGAffineTransform(translationX: translation.x, y: 0)
                    actionShareView.transform = transform
                }
            default :
                break
        }
        
    }
    
    func share(){
        actionShareView.transform = .identity
        print("c'est bon ici")
        let image = UIImage.imageWithView(view: shareView)
        
            let contentToShare = [image]
        
            let activityViewController = UIActivityViewController(activityItems: contentToShare, applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        
    }
}

extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
extension UIImagePickerController
{
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}

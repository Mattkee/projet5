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
    var imageSave = ImageSave()
    
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var blurViewLeft: UIVisualEffectView!
    @IBOutlet weak var slideViewLeft: UIView!
    @IBOutlet weak var customText: UILabel!
    @IBOutlet weak var customText2: UILabel!
    @IBOutlet weak var optionText: UISwitch!
    @IBOutlet weak var textPositionLabel: UILabel!
    @IBOutlet weak var topDownSelector: UISegmentedControl!
    @IBOutlet weak var leftRightSelector: UISegmentedControl!
    @IBOutlet weak var textColorLabel: UILabel!
    @IBOutlet weak var blackWhiteSelector: UISegmentedControl!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var textContentSpace: UITextField!
    @IBOutlet weak var changeText: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1
        
        blurView.layer.cornerRadius = 15
        var translationTransform: CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 150)
        self.slideView.transform = translationTransform
        
        blurViewLeft.layer.cornerRadius = 15
        var translationTransformLeft: CGAffineTransform
        translationTransformLeft = CGAffineTransform(translationX: -250, y: 0)
        self.slideViewLeft.transform = translationTransformLeft
        
        topDownSelector.selectedSegmentIndex = 1
        leftRightSelector.selectedSegmentIndex = 1
        blackWhiteSelector.selectedSegmentIndex = 1
        customText.isHidden = true
        customText2.isHidden = true
        textPositionLabel.isHidden = true
        topDownSelector.isHidden = true
        leftRightSelector.isHidden = true
        textColorLabel.isHidden = true
        blackWhiteSelector.isHidden = true
        textContentLabel.isHidden = true
        textContentSpace.isHidden = true
        changeText.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        disposition2()
        button2.isSelected = true
        button2.setImage(#imageLiteral(resourceName: "Carre2Selec"), for: .selected)
        
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(shareContent(gesture :)))
        actionShareView.addGestureRecognizer(swipe)
        
        let leftEdgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleLeftEdgeAppear(_:)))
        
        let rightEdgePanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleRightEdgeDisappear(_:)))
        
        // set detection edge
        leftEdgePanGesture.edges = UIRectEdge.left
        
        // add gesture into view
        view.addGestureRecognizer(leftEdgePanGesture)
        slideViewLeft.addGestureRecognizer(rightEdgePanGesture)
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
        case .landscapeLeft, .landscapeRight:
            print("Landscape left")
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
    
    @objc func buttonBackgroundwithPhotoLibrary(sender : UIButton) {
        openPhotoLibraryButton(sender: modifiedButton)
    }
    
    @objc func buttonBackgroundWithCamera(sender : UIButton) {
        openCameraButton(sender: modifiedButton)
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
    
    @IBAction func openCamera(_ sender: UIButton) {
        buttonBackgroundWithCamera(sender: modifiedButton)
        var translationTransform : CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 150)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideView.transform = translationTransform
        })
    }
    
    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        buttonBackgroundwithPhotoLibrary(sender: modifiedButton)
        var translationTransform : CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 150)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideView.transform = translationTransform
        })
    }
    
    @IBAction func cancelSlide(_ sender: Any) {
        var translationTransform : CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 150)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideView.transform = translationTransform
        })
        
    }
    
    @IBAction func optionTextAction(_ sender: Any) {
        if optionText.isOn == true {
            customText.isHidden = false
            customText.layer.zPosition = 1
            textPositionLabel.isHidden = false
            topDownSelector.isHidden = false
            leftRightSelector.isHidden = false
            textColorLabel.isHidden = false
            blackWhiteSelector.isHidden = false
            textContentLabel.isHidden = false
            textContentSpace.isHidden = false
            changeText.isHidden = false
            
        } else {
            customText.isHidden = true
            customText2.isHidden = true
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
    
    @IBAction func leftRightSelectorAction(_ sender: UISegmentedControl) {
        if leftRightSelector.selectedSegmentIndex == 0 {
            customText.textAlignment = .left
            customText2.textAlignment = .left
        } else if leftRightSelector.selectedSegmentIndex == 1 {
            customText.textAlignment = .right
            customText2.textAlignment = .right
        }
    }
    
    @IBAction func blackWhiteSelectorAction(_ sender: UISegmentedControl) {
        if blackWhiteSelector.selectedSegmentIndex == 0 {
            customText.textColor = UIColor.black
            customText2.textColor = UIColor.black
        } else if blackWhiteSelector.selectedSegmentIndex == 1 {
            customText.textColor = UIColor.white
            customText2.textColor = UIColor.white
        }
    }
    
    @IBAction func changeTextAction(_ sender: UIButton) {
        
        customText.text = textContentSpace.text
        customText2.text = textContentSpace.text
        
    }
    
    // perform operation when left edge gesture detected
    @objc func handleLeftEdgeAppear( _ gesture: UIScreenEdgePanGestureRecognizer ) {
        var translationTransformLeft: CGAffineTransform
        translationTransformLeft = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.5) {
            self.slideViewLeft.transform = translationTransformLeft
        }
    }
    
    @objc func handleLeftAppearPan( _ gesture: UIPanGestureRecognizer ) {
        let translation = gesture.translation(in: actionShareView)
        
        if translation.x > 0 {
            var translationTransformLeft: CGAffineTransform
            translationTransformLeft = CGAffineTransform(translationX: 0, y: 0)
            UIView.animate(withDuration: 0.5) {
                self.slideViewLeft.transform = translationTransformLeft
            }
        }
    }
    
    // perform operation when right edge gesture detected
    @objc func handleRightEdgeDisappear( _ gesture: UIPanGestureRecognizer ) {
        let translation = gesture.translation(in: slideViewLeft)
        
        if translation.x < 0 {
            var translationTransformLeft: CGAffineTransform
            translationTransformLeft = CGAffineTransform(translationX: -250, y: 0)
            UIView.animate(withDuration: 0.5) {
            self.slideViewLeft.transform = translationTransformLeft
            }
        }
    }
    
    let view1 = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let view2 = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let view3 = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let view4 = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    func launchAction(sender : UIButton) {
        sender.addTarget(self, action: #selector(rightSlide(sender: )), for: .touchUpInside)
    }
    
    @objc func rightSlide(sender : UIButton) {
        modifiedButton = sender
        var translationTransform: CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideView.transform = translationTransform
        })
        
    }
    
    
    func defineStackView(viewArray : [UIView], axe : UILayoutConstraintAxis) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: viewArray)
        stackView.axis = axe
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }
    
    func stackViewContraint(stackView : UIStackView) {
        
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
        
        view1.setImage(imageSave.setButtonImage(viewNumber: 1), for: .normal)
        view1.backgroundColor = UIColor.white
        shareView.addSubview(view1)
        launchAction(sender: view1)
        
        view2.setImage(imageSave.setButtonImage(viewNumber: 2), for: .normal)
        view2.backgroundColor = UIColor.white
        launchAction(sender: view2)
        shareView.addSubview(view2)
        
        
        view3.setImage(imageSave.setButtonImage(viewNumber: 3), for: .normal)
        view3.backgroundColor = UIColor.white
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
        
        view1.setImage(imageSave.setButtonImage(viewNumber: 1), for: .normal)
        view1.backgroundColor = UIColor.white
        shareView.addSubview(view1)
        launchAction(sender: view1)
        
        view2.setImage(imageSave.setButtonImage(viewNumber: 2), for: .normal)
        view2.backgroundColor = UIColor.white
        launchAction(sender: view2)
        shareView.addSubview(view2)
        
        view3.setImage(imageSave.setButtonImage(viewNumber: 3), for: .normal)
        view3.backgroundColor = UIColor.white
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
        
        view1.setImage(imageSave.setButtonImage(viewNumber: 1), for: .normal)
        view1.backgroundColor = UIColor.white
        shareView.addSubview(view1)
        launchAction(sender: view1)
        
        view2.setImage(imageSave.setButtonImage(viewNumber: 2), for: .normal)
        view2.backgroundColor = UIColor.white
        launchAction(sender: view2)
        shareView.addSubview(view2)
        
        view3.setImage(imageSave.setButtonImage(viewNumber: 3), for: .normal)
        view3.backgroundColor = UIColor.white
        launchAction(sender: view3)
        shareView.addSubview(view3)
        
        view4.setImage(imageSave.setButtonImage(viewNumber: 4), for: .normal)
        view4.backgroundColor = UIColor.white
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
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        modifiedButton.setImage(image, for: .normal)
        
        if modifiedButton == view1 {
            imageSave.imageArray[1] = image
            print("view1")
        } else if modifiedButton == view2 {
            imageSave.imageArray[2] = image
            print("view2")
        } else if modifiedButton == view3 {
            imageSave.imageArray[3] = image
            print("view3")
        } else {
            imageSave.imageArray[4] = image
            print("view4")
        }
        
        dismiss(animated:true, completion: nil)
    }
    
    @objc func shareContent(gesture : UIPanGestureRecognizer) {
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
                    if translation.x > 0 {
                        handleLeftAppearPan(gesture)
                    }
            default :
                    transformShareContentViewWith(gesture: gesture)
                }
        case .ended, .cancelled :
            switch UIDevice.current.orientation {
            case .portrait :
                let translation = gesture.translation(in: actionShareView)
                
                if translation.y < 0 {
                   share()
                }
            case .landscapeLeft, .landscapeRight :
                let translation = gesture.translation(in: actionShareView)
                
                if translation.x < 0 {
                   share()
                }
            default :
                break
            }
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
        
        let image = UIImage.imageWithView(view: shareView)
        
            let contentToShare = [image]
            imageSave.imageArray = [Int : UIImage]()
        
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

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
    
    //MARK: Properties
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var blurViewLeft: UIVisualEffectView!
    @IBOutlet weak var slideViewLeft: optionTextSlide!
    @IBOutlet weak var customText: UILabel!
    @IBOutlet weak var customText2: UILabel!
    @IBOutlet weak var optionText: UISwitch!
    @IBOutlet weak var shareView: ShareView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var actionShareView: UIView!
    @IBOutlet weak var viewDispositionButtonOne: UIButton!
    @IBOutlet weak var viewDispositionButtonTwo: UIButton!
    @IBOutlet weak var viewDispositionButtonThree: UIButton!
    @IBOutlet weak var leadingSlideLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSlideDownConstraint: NSLayoutConstraint!
    @IBOutlet var button: [UIButton]!
    
    // in this override func contains Any property or actions that must be launched or available as soon as the app is launched.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // these property concern slide allows to choose camera or library, must not appear when app is launched
        leadingSlideLeftConstraint.constant = 0
        bottomSlideDownConstraint.constant = 0
        
        blurView.layer.cornerRadius = 15
        var translationTransform: CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 150)
        self.slideView.transform = translationTransform
        
        // these property concern slide allows to choose option text, must not appear when app is launched
        blurViewLeft.layer.cornerRadius = 15
        var translationTransformLeft: CGAffineTransform
        translationTransformLeft = CGAffineTransform(translationX: -250, y: 0)
        self.slideViewLeft.transform = translationTransformLeft
        
        // These lines will allow you to hide or set up the initial configuration of the different options for the text.
        customText.isHidden = true
        customText2.isHidden = true
        
        // for observe device orientation.
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        shareView.setViews(topHidden: false, bottomHidden: true)
        viewDispositionButtonImage(buttonOne: false, buttonTwo: true, buttonThree: false)
        
        // gesture for share prepared image.
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(shareContent(gesture :)))
        actionShareView.addGestureRecognizer(swipe)
        
        // gesture allow to appear option text slide.
        let leftEdgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleLeftEdgeAppear(_:)))
        // gesture allow to desappear option text slide.
        let rightEdgePanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleRightEdgeDisappear(_:)))
        
        // set detection edge for option text appear gesture.
        leftEdgePanGesture.edges = UIRectEdge.left
        
        // add gesture into view for option text slide appear or desappear.
        view.addGestureRecognizer(leftEdgePanGesture)
        slideViewLeft.addGestureRecognizer(rightEdgePanGesture)
    }
    
    deinit {
        // for uidevice orientation.
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    // method allow to execute action according the orientation.
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
            for button in button {
                if button.imageView?.image == #imageLiteral(resourceName: "croixbleuseule") {
                    button.setImage(#imageLiteral(resourceName: "croixGriseSeule"), for: .normal)
                }
            }
        case .portrait:
            textLabel.text = "Swipe up to share"
            for button in button {
                if button.imageView?.image == #imageLiteral(resourceName: "croixGriseSeule") {
                    button.setImage(#imageLiteral(resourceName: "croixbleuseule"), for: .normal)
                }
            }
        case .portraitUpsideDown:
            print("Portrait upside down")
        }
    }
    
    // this property is use when subview button is pressed.
    var modifiedButton : UIButton!
    
    //this method allows to display buttons set image.
    func viewDispositionButtonImage(buttonOne : Bool, buttonTwo : Bool, buttonThree : Bool) {
        viewDispositionButtonOne.setImage(#imageLiteral(resourceName: "Carre1Selec"), for: .selected)
        viewDispositionButtonTwo.setImage(#imageLiteral(resourceName: "Carre2Selec"), for: .selected)
        viewDispositionButtonThree.setImage(#imageLiteral(resourceName: "Carre3Selec"), for: .selected)
        viewDispositionButtonOne.isSelected = buttonOne
        viewDispositionButtonTwo.isSelected = buttonTwo
        viewDispositionButtonThree.isSelected = buttonThree
    }
    
    //MARK: Actions
    
    //this method display shareview disposition view and viewdispositionbutton image.
    @IBAction func setLayout(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            shareView.setViews(topHidden: true, bottomHidden: false)
            viewDispositionButtonImage(buttonOne: true, buttonTwo: false, buttonThree: false)
        case 2:
            shareView.setViews(topHidden: false, bottomHidden: true)
            viewDispositionButtonImage(buttonOne: false, buttonTwo: true, buttonThree: false)
        case 3:
            shareView.setViews(topHidden: false, bottomHidden: false)
            viewDispositionButtonImage(buttonOne: false, buttonTwo: false, buttonThree: true)
        default:
            print("error")
        }
    }
    
    //This method allows to appear downslide.
    @IBAction func setButtonImage(_ sender: UIButton) {
        switch sender.tag {
            case 1, 2, 3, 4:
                modifiedButton = sender
                downSlide(sender: sender)
            default:
                print("error")
        }
    }
    
    // this action method allow to call openCameraButton function.
    @IBAction func openCamera(_ sender: UIButton) {
        openCameraButton(sender: modifiedButton)
        var translationTransform : CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 150)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideView.transform = translationTransform
        })
    }
    
    // this action method allow to call openphotolibrarybutton function.
    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        openPhotoLibraryButton(sender: modifiedButton)
        var translationTransform : CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 150)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideView.transform = translationTransform
        })
    }
    
    // this action method allow to disappear slide for camera or library choosen.
    @IBAction func cancelSlide(_ sender: Any) {
        var translationTransform : CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 150)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideView.transform = translationTransform
        })
    }
    
    // perform operation when left edge gesture detected on portrait mode
    @objc func handleLeftEdgeAppear( _ gesture: UIScreenEdgePanGestureRecognizer ) {
        var translationTransformLeft: CGAffineTransform
        translationTransformLeft = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.5) {
            self.slideViewLeft.transform = translationTransformLeft
        }
    }
    
    // perform operation when left edge gesture detected on landscape mode
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
    
    // perform operation when right edge gesture detected on slideviewleft.
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
    
    // this method will allow to display slide to choose camera or photo library.
    @objc func downSlide(sender : UIButton) {
        modifiedButton = sender
        var translationTransform: CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideView.transform = translationTransform
        })
    }
    
    // this method allow to use camera.
    @objc func openCameraButton(sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // this method allow to access photo library.
    @objc func openPhotoLibraryButton(sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // this method allow to use image already choosen.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        modifiedButton.setImage(image, for: .normal)
        modifiedButton.imageView?.contentMode = .scaleAspectFill
        dismiss(animated:true, completion: nil)
    }
    
    // this method allow to access animation for share gesture according device orientation.
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
                    } else if translation.x > 0 {
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
    
    // this method allow to transform share gesture animation.
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
    
    // this method allow to share content.
    func share(){
        actionShareView.transform = .identity
        
        let image = UIImage.imageWithView(view: shareView)
        
        let contentToShare = [image]
        
        optionText.setOn(false, animated: false)
        
        customText.isHidden = true
        customText2.isHidden = true
        
        let activityViewController = UIActivityViewController(activityItems: contentToShare, applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        
    }
}

// this extension allow us to transform UIview to UIimage.
extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

// this extension allow to ajuste uiimagepickercontroller according to orientation device.
extension UIImagePickerController
{
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}

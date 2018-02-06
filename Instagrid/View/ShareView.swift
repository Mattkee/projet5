//
//  ShareView.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 19/01/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class ShareView: UIView {
    
    //MARK: Outlets
    @IBOutlet private var mainStackView : UIStackView!
    @IBOutlet private var topStackView : UIStackView!
    @IBOutlet private var bottomStackView : UIStackView!
    @IBOutlet private var topLeftButton : UIButton!
    @IBOutlet private var topRightButton : UIButton!
    @IBOutlet private var BottomLeftButton : UIButton!
    @IBOutlet private var bottomRightButton : UIButton!
    
    func setViews(topHidden : Bool , bottomHidden : Bool) {
        topLeftButton.isHidden = topHidden
        BottomLeftButton.isHidden = bottomHidden
    }
    
}

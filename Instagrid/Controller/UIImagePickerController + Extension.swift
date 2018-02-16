//
//  UIImagePickerController + Extension.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 16/02/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

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

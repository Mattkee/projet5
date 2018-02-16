//
//  UIImage + Extension.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 16/02/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

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

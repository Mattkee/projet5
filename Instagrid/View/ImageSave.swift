//
//  ImageSave.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 11/01/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

class ImageSave {
    var imageArray = [UIImage]()
    
    func setButtonImage(viewNumber : Int) -> UIImage {
        if viewNumber == 1 && imageArray.count > 0 {
            return imageArray[0]
        } else if viewNumber == 2 && imageArray.count > 1 {
            return imageArray[1]
        } else if viewNumber == 3 && imageArray.count > 2 {
            return imageArray[2]
        } else if viewNumber == 4 && imageArray.count > 3 {
            return imageArray[3]
        } else {
            return #imageLiteral(resourceName: "croixbleuseule")
        }
    }
}

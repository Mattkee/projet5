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
    var imageArray = [Int : UIImage]()
    
    func setButtonImage(viewNumber : Int) -> UIImage {
        
        for (number , image) in imageArray {
            
            if viewNumber == number {
                return image
            }
        }
        return #imageLiteral(resourceName: "croixbleuseule")
    }
}

//
//  ImageSave.swift
//  Instagrid
//
//  Created by Lei et Matthieu on 11/01/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

// this class will allow to save already selected image in dictionnary.
class ImageSave {
    var imageArray = [Int : UIImage]()
    
    // this method will allow to return image to selected view if dictionnary already save an image for this selected view
    func setButtonImage(viewNumber : Int) -> UIImage {
        
        for (number , image) in imageArray {
            
            if viewNumber == number {
                return image
            }
        }
        return #imageLiteral(resourceName: "croixbleuseule")
    }
}

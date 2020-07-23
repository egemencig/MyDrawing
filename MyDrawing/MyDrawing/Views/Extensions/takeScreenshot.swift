//
//  takeScreenshot.swift
//  MyDrawing
//
//  Created by Egemen Çığ on 2.07.2020.
//  Copyright © 2020 Egemen Çığ. All rights reserved.
//

import UIKit

extension UIView {

    func takeScreenshot() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}

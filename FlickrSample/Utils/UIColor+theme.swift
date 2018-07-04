//
//  UIColor+theme.swift
//  FlickrSample
//
//  Created by Dylan Bruschi on 7/2/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return  UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let teal = UIColor.rgb(red: 45, green: 137, blue: 185)
    static let darkGreen = UIColor.rgb(red: 37, green: 63, blue: 54)
    static let lightGreen = UIColor.rgb(red: 228, green: 242, blue: 231)
}


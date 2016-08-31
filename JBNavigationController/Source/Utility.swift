//
//  Utility.swift
//  JBNavigationController
//
//  Created by Jacob Benton on 8/29/16.
//  Copyright © 2016 jakebent. All rights reserved.
//

import UIKit

class Utility: NSObject {
    static var deviceHeight: CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
    static var deviceWidth: CGFloat {
        return UIScreen.mainScreen().bounds.width
    }

    static let colors = [
        UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.yellowColor(),
        UIColor.greenColor(),
        UIColor.cyanColor(),
        UIColor.blueColor(),
        UIColor.purpleColor(),
        UIColor.magentaColor(),
        UIColor.lightGrayColor(),
        UIColor.grayColor(),
        UIColor.darkGrayColor()
    ]
}

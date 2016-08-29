//
//  ViewController.swift
//  JBNavigationController
//
//  Created by Jacob Benton on 8/29/16.
//  Copyright © 2016 jakebent. All rights reserved.
//

import UIKit

private extension Selector {
    static let push = #selector(ViewController.pushNewViewController)
}

class ViewController: UIViewController {

    static let colors = [
        (color: UIColor.redColor(), title: "red"),
        (color: UIColor.orangeColor(), title: "orange"),
        (color: UIColor.yellowColor(), title: "yellow"),
        (color: UIColor.greenColor(), title: "green"),
        (color: UIColor.cyanColor(), title: "cyan"),
        (color: UIColor.blueColor(), title: "blue"),
        (color: UIColor.purpleColor(), title: "purple"),
        (color: UIColor.magentaColor(), title: "magenta"),
        (color: UIColor.lightGrayColor(), title: "light gray"),
        (color: UIColor.grayColor(), title: "gray"),
        (color: UIColor.darkGrayColor(), title: "dark gray"),
        (color: UIColor.blackColor(), title: "black")
    ]

    let pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("Push me", forState: .Normal)
        button.setTitleColor(.whiteColor(), forState: .Normal)
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 50
        button.layer.rasterizationScale = UIScreen.mainScreen().scale
        button.layer.shouldRasterize = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(pushButton)
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        pushButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        pushButton.heightAnchor.constraintEqualToConstant(100).active = true
        pushButton.widthAnchor.constraintEqualToConstant(100).active = true

        pushButton.addTarget(self, action: .push, forControlEvents: .TouchUpInside)

        let colorIndex = Int(arc4random_uniform(UInt32(ViewController.colors.count)))
        view.backgroundColor = ViewController.colors[colorIndex].color
        title = ViewController.colors[colorIndex].title.uppercaseString
    }

    @objc private func pushNewViewController() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}


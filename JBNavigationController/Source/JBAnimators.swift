//
//  JBAnimators.swift
//  JBNavigationController
//
//  Created by Jacob Benton on 8/29/16.
//  Copyright © 2016 jakebent. All rights reserved.
//

import UIKit

class JBInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let direction: JBNavigationController.JBNavigationDirection

    init(direction: JBNavigationController.JBNavigationDirection) {
        self.direction = direction
        super.init()
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return JBNavigationController.animationDuration
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let
            toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            containerView = transitionContext.containerView()
            else { return }

        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)

        var fromFrame: CGRect
        let toFrame = CGRect(x: 0, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)

        switch direction {
        case .Left:
            fromFrame = CGRect(x: -Utility.deviceWidth, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)

        case .Right:
            fromFrame = CGRect(x: Utility.deviceWidth, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)

        case .Up:
            fromFrame = CGRect(x: 0, y: Utility.deviceHeight, width: Utility.deviceWidth, height: Utility.deviceHeight)

        case .Down:
            fromFrame = CGRect(x: 0, y: -Utility.deviceHeight, width: Utility.deviceWidth, height: Utility.deviceHeight)

        }

        toViewController.view.frame = fromFrame

        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            toViewController.view.frame = toFrame
        }) { (_) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}

class JBOutAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let direction: JBNavigationController.JBNavigationDirection

    init(direction: JBNavigationController.JBNavigationDirection) {
        self.direction = direction
        super.init()
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return JBNavigationController.animationDuration
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let
            toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            containerView = transitionContext.containerView()
            else { return }

        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)

        let fromFrame = CGRect(x: 0, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)
        var toFrame: CGRect

        switch direction {
        case .Left:
            toFrame = CGRect(x: -Utility.deviceWidth, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)

        case .Right:
            toFrame = CGRect(x: Utility.deviceWidth, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)

        case .Up:
            toFrame = CGRect(x: 0, y: Utility.deviceHeight, width: Utility.deviceWidth, height: Utility.deviceHeight)

        case .Down:
            toFrame = CGRect(x: 0, y: -Utility.deviceHeight, width: Utility.deviceWidth, height: Utility.deviceHeight)
            
        }

        fromViewController.view.frame = fromFrame

        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            fromViewController.view.frame = toFrame
        }) { (_) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
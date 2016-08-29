//
//  JBAnimators.swift
//  JBNavigationController
//
//  Created by Jacob Benton on 8/29/16.
//  Copyright © 2016 jakebent. All rights reserved.
//

import UIKit

class JBFromRightInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
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

        toViewController.view.frame = CGRect(x: Utility.deviceWidth, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)

        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            toViewController.view.frame = CGRect(x: 0, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)
        }) { (_) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}

class JBFromRightOutAnimator: NSObject, UIViewControllerAnimatedTransitioning {
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

        fromViewController.view.frame = CGRect(x: 0, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)

        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            fromViewController.view.frame = CGRect(x: Utility.deviceWidth, y: 0, width: Utility.deviceWidth, height: Utility.deviceHeight)
        }) { (_) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
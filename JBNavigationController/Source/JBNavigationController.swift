//
//  JBNavigationController.swift
//  JBNavigationController
//
//  Created by Jacob Benton on 8/29/16.
//  Copyright © 2016 jakebent. All rights reserved.
//

import UIKit

private extension Selector {
    static let popSwipe = #selector(JBNavigationController.popSwipe(_:))
}

class JBNavigationController: UINavigationController, UINavigationControllerDelegate {
    static var animationDuration: NSTimeInterval = 0.3

    private var interactionController: UIPercentDrivenInteractiveTransition? = nil
    private var forwardHistory: UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {

        viewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: .popSwipe))
    }

    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if forwardHistory == viewController {
            forwardHistory = nil
        }
    }

    var gestureState: UIGestureRecognizerState? = nil
    var navigationState: NavigationState = .None
    enum NavigationState {
        case Pushing
        case Popping
        case None
    }

    func popSwipe(gesture: UIScreenEdgePanGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        let velocity = gesture.velocityInView(gestureView).x
        let translation = gesture.translationInView(gestureView).x

        if gesture.state == .Began {
            navigationState = velocity > 0 ? .Popping : .Pushing
        }

        if navigationState == .Popping {
            handleSwipe(
                inView: gestureView,
                translation: translation,
                velocity: velocity,
                gestureState: gesture.state,
                operation: { () -> Void in
                    self.popViewControllerAnimated(true)
                }
            )
        } else if navigationState == .Pushing {
            guard let nextViewController = forwardHistory else { return }

            handleSwipe(
                inView:  gestureView,
                translation: translation,
                percentThreshold: 0.5,
                velocity: velocity * -1,
                gestureState: gesture.state,
                operation: { () -> Void in
                    self.pushViewController(nextViewController, animated: true)
                }
            )
        }

        if gesture.state == .Ended || gesture.state == .Cancelled || gesture.state == .Failed {
            navigationState = .None
        }
    }

    func handleSwipe(inView view: UIView, translation: CGFloat, percentThreshold: CGFloat = 0.35, velocity: CGFloat, gestureState: UIGestureRecognizerState, operation: () -> Void) {

        let percent = fabs(translation / view.bounds.size.width)
        if gestureState == .Began {
            guard velocity > 0 else { return }
            interactionController = UIPercentDrivenInteractiveTransition()
            operation()
        } else if gestureState == .Changed {
            if (navigationState == .Popping && translation >= 0) || navigationState == .Pushing {
                interactionController?.updateInteractiveTransition(percent)
            }
        } else if gestureState == .Ended || gestureState == .Cancelled || gestureState == .Failed {
            if (percent > percentThreshold || velocity > 300) {
                interactionController?.finishInteractiveTransition()
            } else {
                interactionController?.cancelInteractiveTransition()
                forwardHistory = nil
            }
            interactionController = nil
        }
    }

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .Push:
            return JBFromRightInAnimator()
        case .Pop:
            forwardHistory = fromVC
            return JBFromRightOutAnimator()
        default:
            return nil
        }
    }

    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}

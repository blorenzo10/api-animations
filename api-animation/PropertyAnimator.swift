//
//  PropertyAnimator.swift
//  api-animation
//
//  Created by Bruno Lorenzo on 7/26/20.
//  Copyright © 2020 blorenzo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewPropertyAnimator {
    
    static func animator(from animation: CustomAnimation) -> UIViewPropertyAnimator {
        if let ratio = animation.dumpingRatio {
            return .init(duration: animation.duration, dampingRatio: ratio)
        }
        return .init(duration: animation.duration, curve: animation.curve)
    }
    
    static func executePreAnimationTransform(_ animations: [CustomAnimation], to view: UIView) {
        animations.map({ $0.preAnimationBlock }).forEach {
            if let animationBlock = $0 {
                animationBlock(view)
            }
        }
    }
    
    func addCustomAnimationCompletion(_ completion: CustomAnimation.AnimationCompletionBlock?, to view: UIView) {
        addCompletion { position in
            if position == .end {
                completion?(view)
            }
        }
    }
    
    func addCustomAnimation(_ animationBlock: @escaping CustomAnimation.AnimationBlock, to view: UIView, withDelay delay: CGFloat = 0) {
        addAnimations({
            animationBlock(view)
        }, delayFactor: delay)
    }
}

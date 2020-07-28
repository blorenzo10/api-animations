//
//  View.swift
//  api-animation
//
//  Created by Bruno Lorenzo on 7/25/20.
//  Copyright © 2020 blorenzo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func performeAnimations(_ mode: CustomAnimation.AnimationMode, with animations: CustomAnimation...) {
        var animators = [UIViewPropertyAnimator]()
        
        animations.forEach {
            let newAnimator = UIViewPropertyAnimator.animator(from: $0)
            newAnimator.addCustomAnimation($0.animationBlock, to: self)
            newAnimator.addCustomAnimationCompletion($0.animationCompletionBlock, to: self)
            animators.append(newAnimator)
        }

        UIViewPropertyAnimator.executePreAnimationTransform(animations, to: self)
        var delay = 0.0
        animators.forEach {
            $0.startAnimation(afterDelay: delay)
            delay = mode == .inSequence ? $0.duration : 0.0
        }
    }
    
    func performeAnimation(_ animation: CustomAnimation) {
        performeAnimations(.inParallel, with: animation)
    }
}

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
    
    func performeAnimations(_ mode: CustomAnimation.AnimationMode, with animations: [CustomAnimation]) {
        switch mode {
        case .inSequence:
            performeAnimattionsInSequence(animations)
        case .inParallele:
            performeAnimationsInParallele(animations)
        }
    }
    
    private func performeAnimationsInParallele(_ animations: [CustomAnimation]) {
        for animation in animations {
            executeCustomAnimationBlock(animation)
        }
    }
    
    private func performeAnimattionsInSequence(_ animations: [CustomAnimation]) {
        var animationsLeft = animations
        let nextAnimation = animationsLeft.removeFirst()
        executeCustomAnimationBlock(nextAnimation, animationsLeft)
    }
    
    private func executeCustomAnimationBlock(_ animation: CustomAnimation, _ animationsLeft: [CustomAnimation] = []) {
        animation.preAnimationBlock?(self)
        UIView.animate(withDuration: animation.duration, delay: animation.delay, options: animation.options, animations: {
            animation.animationBlock(self)
        }, completion: {_ in
            animation.animationCompletionBlock?()
            if !animationsLeft.isEmpty {
                self.performeAnimattionsInSequence(animationsLeft)
            }
        })
    }
}

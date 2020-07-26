//
//  CustomAnimation.swift
//  api-animation
//
//  Created by Bruno Lorenzo on 7/25/20.
//  Copyright © 2020 blorenzo. All rights reserved.
//

import Foundation
import UIKit

enum AnimationType: Equatable {
    case fade(FadeType)
    case scale(ScaleType)
}

extension AnimationType {
    enum FadeType {
        case fadeIn
        case fadeOut
    }
    
    enum ScaleType {
        case scaleIn
        case scaleOut
    }
}

public struct CustomAnimation {
    
    let duration: TimeInterval
    let delay: TimeInterval
    var options: UIView.AnimationOptions
    let animationBlock: AnimationBlock
    var preAnimationBlock: PreAnimationBlock?
    var animationCompletionBlock: AnimationCompletionBlock?
    
    init(duration: TimeInterval, delay: TimeInterval = 0, options: UIView.AnimationOptions = [], animationBlock: @escaping AnimationBlock, preAnimationBlock: PreAnimationBlock? = nil, animationCompletionBlock: AnimationCompletionBlock? = nil) {
        self.duration = duration
        self.delay = delay
        self.options = options
        self.animationBlock = animationBlock
        self.preAnimationBlock = preAnimationBlock
        self.animationCompletionBlock = animationCompletionBlock
    }
}

// MARK: - Utility

extension CustomAnimation {
    typealias AnimationBlock = (UIView) -> Void
    typealias PreAnimationBlock = (UIView) -> Void
    typealias AnimationCompletionBlock = () -> Void
    typealias ScaleFactor = (x: CGFloat, y: CGFloat)
    
    enum AnimationMode {
        case inParallele
        case inSequence
    }
}

// MARK: - Public Constructors

extension CustomAnimation {
        
    static func fade(_ type: AnimationType.FadeType, withDuration duration: TimeInterval = 0.3, onCompletion completion: AnimationCompletionBlock? = nil) -> CustomAnimation {
        switch type {
        case .fadeIn:
            return fadeIn(withDuration: duration, completion: completion)
        case .fadeOut:
            return fadeOut(withDuration: duration, completion: completion)
        }
    }
    
    static func scale(_ type: AnimationType.ScaleType, withDuration duration: TimeInterval = 0.3, scaleFactor: ScaleFactor, onCompletion completion: AnimationCompletionBlock? = nil) -> CustomAnimation {
        switch type {
        case .scaleIn:
            return scaleIn(withDuration: duration, scaleFactor: scaleFactor, completion: completion)
        case .scaleOut:
            return scaleOut(withDuration: duration, scaleFactor: scaleFactor, completion: completion)
        }
    }
}

// MARK: - Builders

private extension CustomAnimation {

    // MARK: - Fade
    
    private static func fadeIn(withDuration duration: TimeInterval, completion: AnimationCompletionBlock?) -> CustomAnimation {
        return CustomAnimation(duration: duration, animationBlock: { view in
            view.alpha = 1
        }, preAnimationBlock: { view in
            view.alpha = 0
        }, animationCompletionBlock: completion)
    }
    
    private static func fadeOut(withDuration duration: TimeInterval, completion: AnimationCompletionBlock?) -> CustomAnimation {
        return CustomAnimation(duration: duration, animationBlock: { view in
            view.alpha = 0
        }, animationCompletionBlock: completion)
    }
    
    // MARL: - Scale
    
    private static func scaleIn(withDuration duration: TimeInterval, scaleFactor: ScaleFactor, completion: AnimationCompletionBlock?) -> CustomAnimation {
        return CustomAnimation(duration: duration, animationBlock: { view in
            view.transform = .identity
        }, preAnimationBlock: { view in
            view.transform = .init(scaleX: scaleFactor.x, y: scaleFactor.y)
        }, animationCompletionBlock: completion)
    }
    
    private static func scaleOut(withDuration duration: TimeInterval, scaleFactor: ScaleFactor, completion: AnimationCompletionBlock?) -> CustomAnimation {
        return CustomAnimation(duration: duration, animationBlock: { view in
            view.transform = .init(scaleX: scaleFactor.x, y: scaleFactor.y)
        }, preAnimationBlock: { view in
            view.transform = .identity
        }, animationCompletionBlock: completion)
    }
}

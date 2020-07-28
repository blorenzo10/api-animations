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
    case bounce(BounceType)
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
    
    enum BounceType {
        case bounceIn
        case bounceOut
    }
}

public struct CustomAnimation {
    
    let duration: TimeInterval
    let delay: CGFloat
    let dumpingRatio: CGFloat?
    var curve: UIView.AnimationCurve
    let animationBlock: AnimationBlock
    var preAnimationBlock: PreAnimationBlock?
    var animationCompletionBlock: AnimationCompletionBlock?
    
    init(duration: TimeInterval, delay: CGFloat = 0, dumpingRatio: CGFloat? = nil, curve: UIView.AnimationCurve = .easeInOut, animationBlock: @escaping AnimationBlock, preAnimationBlock: PreAnimationBlock? = nil, animationCompletionBlock: AnimationCompletionBlock? = nil) {
        self.duration = duration
        self.delay = delay
        self.dumpingRatio = dumpingRatio
        self.curve = curve
        self.animationBlock = animationBlock
        self.preAnimationBlock = preAnimationBlock
        self.animationCompletionBlock = animationCompletionBlock
    }
}

// MARK: - Utility

extension CustomAnimation {
    typealias AnimationBlock = (UIView) -> Void
    typealias PreAnimationBlock = (UIView) -> Void
    typealias AnimationCompletionBlock = (UIView) -> Void
    typealias ScaleFactor = (x: CGFloat, y: CGFloat)
    
    enum AnimationMode {
        case inParallel
        case inSequence
    }
}

// MARK: - Public Constructors

extension CustomAnimation {
        
    static func fade(_ type: AnimationType.FadeType, withDuration duration: TimeInterval = 0.3, delay: CGFloat = 0, onCompletion completion: AnimationCompletionBlock? = nil) -> CustomAnimation {
        switch type {
        case .fadeIn:
            return fadeIn(withDuration: duration, delay: delay, completion: completion)
        case .fadeOut:
            return fadeOut(withDuration: duration, delay: delay, completion: completion)
        }
    }
    
    static func scale(_ type: AnimationType.ScaleType, withDuration duration: TimeInterval = 0.3, delay: CGFloat = 0, scaleFactor: ScaleFactor, onCompletion completion: AnimationCompletionBlock? = nil) -> CustomAnimation {
        switch type {
        case .scaleIn:
            return scaleIn(withDuration: duration, delay: delay, scaleFactor: scaleFactor, completion: completion)
        case .scaleOut:
            return scaleOut(withDuration: duration, delay: delay, scaleFactor: scaleFactor, completion: completion)
        }
    }
    
    static func bounce(_ type: AnimationType.BounceType, withDuration duration: TimeInterval = 0.3, delay: CGFloat = 0, dumpingRatio: CGFloat = 0.2, scaleFactor: ScaleFactor, onCompletion completion: AnimationCompletionBlock? = nil) -> CustomAnimation {
        switch type {
        case .bounceIn:
            return bounceIn(withDuration: duration, delay: delay, dumpingRatio: dumpingRatio, scaleFactor: scaleFactor, completion: completion)
        case .bounceOut:
            return bounceOut(withDuration: duration, delay: delay, dumpingRatio: dumpingRatio, scaleFactor: scaleFactor, completion: completion)
        }
    }
}

// MARK: - Builders

private extension CustomAnimation {

    // MARK: - Fade
    
    private static func fadeIn(withDuration duration: TimeInterval, delay: CGFloat = 0, completion: AnimationCompletionBlock?) -> CustomAnimation {
        return CustomAnimation(duration: duration, delay: delay, animationBlock: { view in
            view.alpha = 1
        }, preAnimationBlock: { view in
            view.alpha = 0
        }, animationCompletionBlock: completion)
    }
    
    private static func fadeOut(withDuration duration: TimeInterval, delay: CGFloat = 0, completion: AnimationCompletionBlock?) -> CustomAnimation {
        return CustomAnimation(duration: duration, delay: delay, animationBlock: { view in
            view.alpha = 0
        }, animationCompletionBlock: completion)
    }
    
    // MARK: - Scale
    
    private static func scaleIn(withDuration duration: TimeInterval, delay: CGFloat, scaleFactor: ScaleFactor, completion: AnimationCompletionBlock?) -> CustomAnimation {
        return CustomAnimation(duration: duration, delay: delay, animationBlock: { view in
            view.transform = .init(scaleX: scaleFactor.x, y: scaleFactor.y)
        }, animationCompletionBlock: completion)
    }
    
    private static func scaleOut(withDuration duration: TimeInterval, delay: CGFloat, scaleFactor: ScaleFactor, completion: AnimationCompletionBlock?) -> CustomAnimation {
        return CustomAnimation(duration: duration, delay: delay, animationBlock: { view in
            view.transform = .init(scaleX: scaleFactor.x, y: scaleFactor.y)
        }, preAnimationBlock: { view in
            view.transform = .identity
        }, animationCompletionBlock: completion)
    }
    
    // MARK: - Bounce
    
    private static func bounceIn(withDuration duration: TimeInterval, delay: CGFloat, dumpingRatio: CGFloat, scaleFactor: ScaleFactor, completion: AnimationCompletionBlock?) -> CustomAnimation {
        
        return CustomAnimation(duration: duration, delay: delay, dumpingRatio: dumpingRatio, animationBlock: { view in
            view.transform = .identity
        }, preAnimationBlock: { view in
            view.transform = .init(scaleX: scaleFactor.x, y: scaleFactor.y)
        }, animationCompletionBlock: completion)
    }
    
    private static func bounceOut(withDuration duration: TimeInterval, delay: CGFloat, dumpingRatio: CGFloat, scaleFactor: ScaleFactor, completion: AnimationCompletionBlock?) -> CustomAnimation {
        
        return CustomAnimation(duration: duration, delay: delay, dumpingRatio: dumpingRatio, animationBlock: { view in
            view.transform = .init(scaleX: scaleFactor.x, y: scaleFactor.y)
        }, animationCompletionBlock: completion)
    }
}

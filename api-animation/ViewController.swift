//
//  ViewController.swift
//  api-animation
//
//  Created by Bruno Lorenzo on 7/25/20.
//  Copyright © 2020 blorenzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let squareView = UIView()
    private lazy var startAnimationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Animate!", for: .normal)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        squareView.backgroundColor = .black
        view.addSubview(squareView)
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        squareView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(startAnimationButton)
        startAnimationButton.translatesAutoresizingMaskIntoConstraints = false
        startAnimationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        startAnimationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startAnimationButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }


}

extension ViewController {
    
    @objc
    private func animate() {
        
        let completionHandler: CustomAnimation.AnimationCompletionBlock = { view in
            view.transform = .identity
            view.alpha = 1
        }
        
//        squareView.performeAnimation(.fade(.fadeIn, withDuration: 2, onCompletion: completionHandler))
        
//        squareView.performeAnimations(.inParallel,
//            with:
//            .scale(.scaleIn, withDuration: 1.5, scaleFactor: CustomAnimation.ScaleFactor(x: 1.3, y: 1.3)),
//            .fade(.fadeIn, withDuration: 3.0, onCompletion: completionHandler))
        
//        squareView.performeAnimations(.inSequence,
//            with:
//            .bounce(.bounceOut, withDuration: 2.0, scaleFactor: CustomAnimation.ScaleFactor(x: 1.3, y: 1.3)),
//            .fade(.fadeOut, withDuration: 1.0, onCompletion: completionHandler))
        
        squareView.performeAnimations(.inSequence,
            with:
            .scale(.scaleOut, scaleFactor: CustomAnimation.ScaleFactor(x: 1.3, y: 1.3)),
            .bounce(.bounceOut, withDuration: 1, dumpingRatio: 0.3, scaleFactor: CustomAnimation.ScaleFactor(x: 0.3, y: 0.3)),
            .fade(.fadeOut, withDuration: 0.3, onCompletion: completionHandler)
        )
    }
}

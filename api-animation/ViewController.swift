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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        squareView.backgroundColor = .black
        view.addSubview(squareView)
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        squareView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        animate()
    }


}

extension ViewController {
    
    private func animate() {
        let animations: [CustomAnimation] = [
            .fade(.fadeIn, withDuration: 3.0),
            .scale(.scaleIn, withDuration: 3.0, scaleFactor: CustomAnimation.ScaleFactor(x: 1.3, y: 1.3))
        ]
        
        squareView.performeAnimations(.inParallele, with: animations)
    }
}

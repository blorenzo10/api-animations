# API - Animation
This is an animation wrapper built over UIViewPropertyAnimator in order to make the animations code more readable and clean

### Usage
`````swift
view.performeAnimations(.inParallel,
	with:
		.scale(.scaleIn, withDuration: 1.5, scaleFactor: CustomAnimation.ScaleFactor(x: 1.3, y: 1.3)),
		.fade(.fadeIn, withDuration: 3.0, onCompletion: completionHandler))
		
squareView.performeAnimations(.inSequence,
	with:
		.bounce(.bounceOut, withDuration: 2.0, scaleFactor: CustomAnimation.ScaleFactor(x: 1.3, y: 1.3)),
		 .fade(.fadeOut, withDuration: 1.0, onCompletion: completionHandler))
```

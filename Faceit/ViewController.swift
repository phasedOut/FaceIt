//
//  ViewController.swift
//  Faceit
//
//  Created by Yuji Sakai on 2017/10/15.
//  Copyright © 2017 Yuji Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //view
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            //update when model is set (will be called only once)
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            faceView.addGestureRecognizer(tapRecognizer)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            updateUI()
        }
    }
    
   @objc func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            var eyes: FacialExpression.Eyes = expression.eyes
            switch eyes {
            case .closed:
                eyes = .open
            default:
                eyes = .closed
            }
            expression.eyes = eyes
        }
    }
    
    @objc func increaseHappiness() {
        expression = expression.happier
    }
    
    @objc func decreaseHappiness() {
        expression = expression.sadder
    }
    
    //model
    var expression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            //update every time view changes
            updateUI()
        }
    }
    
    //update view when model changes
    private func updateUI() {
        //one way to set view
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        //this way is possible too
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0
    }
    
    private let mouthCurvatures = [
        FacialExpression.Mouth.grin:0.5,
        .frown:-1.0,
        .smile:1.0,
        .neutral:0,
        .smirk:-0.5
    ]
    

}


//
//  ViewController.swift
//  Faceit
//
//  Created by Yuji Sakai on 2017/10/15.
//  Copyright © 2017 Yuji Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //model
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            //update when model is set (will be called only once)
            updateUI()
        }
    }
    
    //view
    var expression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            //update every time view changes
            updateUI()
        }
    }
    
    //update model when view changes
    private func updateUI() {
        //one way to set model
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


//
//  CircleButton.swift
//  Transcribe
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/17/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit


@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet{
            setUpView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView(){
        layer.cornerRadius = cornerRadius
    }

}

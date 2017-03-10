//
//  LoginAnimateView.swift
//  HandyMan
//
//  Created by Don Johnson on 5/3/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

import UIKit

final class LoginAnimateView: DesignableView {
    
    override func draw(_ rect: CGRect) {
        if let color = backgroundColor {
            color.setFill()
        }
        UIRectFill(rect)
        
        let layer = CAShapeLayer()
        let path = CGMutablePath()
        
        _ = CGMutablePath.addEllipse(path)
        _ = CGMutablePath.addRect(path)
        
        layer.path = path
        layer.fillRule = kCAFillRuleEvenOdd
        self.layer.mask = layer
    }
    
}

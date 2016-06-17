//
//  LoginAnimateView.swift
//  HandyMan
//
//  Created by Don Johnson on 5/3/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

import UIKit

class LoginAnimateView: DesignableView {
    
    override func drawRect(rect: CGRect) {
        if let color = backgroundColor {
            color.setFill()
        }
        UIRectFill(rect)
        
        let layer = CAShapeLayer()
        let path = CGPathCreateMutable()
        
        
        let holeEnclosingRect = rect
        CGPathAddEllipseInRect(path, nil, holeEnclosingRect) // use CGPathAddRect() for rectangular hole
        /*
         // Draws only one circular hole
         let holeRectIntersection = CGRectIntersection(holeRect, rect)
         let context = UIGraphicsGetCurrentContext()
         
         if( CGRectIntersectsRect(holeRectIntersection, rect))
         {
         CGContextBeginPath(context);
         CGContextAddEllipseInRect(context, holeRectIntersection)
         //CGContextDrawPath(context, kCGPathFillStroke)
         CGContextClip(context)
         //CGContextClearRect(context, holeRectIntersection)
         CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
         CGContextFillRect(context, holeRectIntersection)
         CGContextClearRect(context, holeRectIntersection)
         }*/
        
        CGPathAddRect(path, nil, self.bounds)
        layer.path = path
        layer.fillRule = kCAFillRuleEvenOdd
        self.layer.mask = layer
    }
    
}

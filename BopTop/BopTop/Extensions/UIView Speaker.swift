//
//  UIView Speaker.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/17/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit

class SpeakerView: UIView {
    
    var boxLayer: CAShapeLayer?
    var topLayer: CAShapeLayer?
    var bottomLayer: CAShapeLayer?
    var topSmallLayer: CAShapeLayer?
    var bottomSmallLayer: CAShapeLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = frame.width
        
        boxLayer = self.boxLayer(width: width)
        boxLayer?.position = CGPoint.init(x: -width/2, y: -width*0.75)
        topLayer = self.topLayer(width: width)
        topLayer?.position = CGPoint.init(x: self.center.x - width/2, y: -width/2.5)
        bottomLayer = self.bottomLayer(width: width)
        bottomLayer?.position = CGPoint.init(x: self.center.x - width/2, y: width/3)
        topSmallLayer = self.topSmallLayer(width: width)
        topSmallLayer?.position = CGPoint.init(x: self.center.x - width/2, y: -width/2.5)
        bottomSmallLayer = self.bottomSmallLayer(width: width)
        bottomSmallLayer?.position = CGPoint.init(x: self.center.x - width/2, y: width/3)
        self.layer.addSublayer(boxLayer!)
        self.layer.addSublayer(bottomLayer!)
        self.layer.addSublayer(topLayer!)
        self.layer.addSublayer(bottomSmallLayer!)
        self.layer.addSublayer(topSmallLayer!)
    }
    
    func animatePulsatingLayer() {
        let topAnimation = CABasicAnimation(keyPath: "transform.scale")
        topAnimation.toValue = 1.2
        topAnimation.duration = 0.1
        topAnimation.autoreverses = true
        topAnimation.repeatCount = Float.infinity
        
        let bottomAnimation = CABasicAnimation(keyPath: "transform.scale")
        bottomAnimation.toValue = 1.25
        bottomAnimation.duration = 0.17
        bottomAnimation.autoreverses = true
        bottomAnimation.repeatCount = Float.infinity
        
        topLayer?.add(topAnimation, forKey: "outerPulse")
        bottomLayer?.add(bottomAnimation, forKey: "innerPulse")
    }
    
    func stopAnimatingPulsatingLayer() {
        topLayer?.removeAllAnimations()
        bottomLayer?.removeAllAnimations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func boxLayer(width: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: width, height: width*1.6), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: width*0.17, height: width*0.17)).cgPath
        layer.strokeColor = UIColor.yellow.cgColor
        layer.lineWidth = 0
        layer.fillColor = UIColor.yellow.cgColor
        layer.lineCap = kCALineCapRound
        return layer
    }
    
    func topLayer(width: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(arcCenter: .zero, radius: 0.17*width, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 0
        layer.fillColor = UIColor.black.cgColor
        layer.lineCap = kCALineCapRound
        return layer
    }
    
    func bottomLayer(width: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(arcCenter: .zero, radius: width*0.34, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 0
        layer.fillColor = UIColor.black.cgColor
        layer.lineCap = kCALineCapRound
        return layer
    }
    
    func topSmallLayer(width: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(arcCenter: .zero, radius: width*0.09, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        layer.strokeColor = UIColor.darkGray.cgColor
        layer.lineWidth = 0
        layer.fillColor = UIColor.darkGray.cgColor
        layer.lineCap = kCALineCapRound
        return layer
    }
    
    func bottomSmallLayer(width: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(arcCenter: .zero, radius: width*0.17, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        layer.strokeColor = UIColor.darkGray.cgColor
        layer.lineWidth = 0
        layer.fillColor = UIColor.darkGray.cgColor
        layer.lineCap = kCALineCapRound
        return layer
    }
}

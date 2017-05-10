//
//  JOnePixLineView.swift
//  Poems
//
//  Created by Neo on 2016/11/5.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

enum JOnePixMode {
    case horizontal
    case vertical
}

class JOnePixLineView: UIView {
    
    var lineColor: UIColor? {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    var mode: JOnePixMode = .horizontal {
        didSet {
            switch mode {
            case .horizontal:
                self.height = 1
            default:
                self.width = 1
            }
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        var bottomInset: CGFloat
        if UIScreen.main.scale > 1 {
            bottomInset = 0.25
        } else {
            bottomInset = 0.5
        }
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.setLineWidth(0.5)
        if lineColor == nil {
            lineColor = UIColor.gray
        }
        context.setStrokeColor((lineColor?.cgColor)!)
        if mode == .horizontal {
            context.move(to: CGPoint(x:0 ,y:rect.height-bottomInset))
            context.addLine(to: CGPoint(x: rect.width, y: rect.height - bottomInset))
        } else {
            context.move(to: CGPoint(x: rect.width, y: 0))
            context.addLine(to: CGPoint(x: rect.width-bottomInset, y: rect.height))
        }
        context.strokePath()
        context.restoreGState()
    }
}

//
//  BubbleView.swift
//  Bubble
//
//  Created by Hansub Yoo on 2022/07/19.
//

import UIKit

class BubbleView: UIView {
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect)
        
        // 색상
        UIColor.systemRed.setFill()
        circlePath.fill()
        
        // 테두리
        UIColor.black.setStroke()
        circlePath.stroke()
        
        // 광택 효과(arc)
        let lightPath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: (bounds.height / 2 - 8),
            startAngle: .pi,
            endAngle: 1.5 * .pi,
            clockwise: true
        )
        UIColor.black.setStroke()
        lightPath.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        // 둥근 모서리(클리핑)
        // 꼭 init이 아니라 layoutSubviews에서 갱신해도 됨
        self.layer.cornerRadius = frame.height / 2
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  BubbleView.swift
//  Bubble
//
//  Created by Hansub Yoo on 2022/07/19.
//

import UIKit

class BubbleView: UIView {
    var bubbleColor: UIColor = .systemRed // 외부에서 바꿀 수 있게
    
    override func draw(_ rect: CGRect) {
        // 원형
        let circlePath = UIBezierPath(ovalIn: rect)
        
        // 색상 채우기
        bubbleColor.setFill()
        circlePath.fill()

        // 테두리
        UIColor.black.setStroke()
        circlePath.stroke()

        // 광택(arc) 효과 (원하면 지워도 됨)
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
        backgroundColor = .clear
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

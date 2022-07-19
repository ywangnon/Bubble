//
//  BubbleView.swift
//  Bubble
//
//  Created by Hansub Yoo on 2022/07/19.
//

import UIKit

class BubbleView: UIView {
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(roundedRect: rect,
                                      cornerRadius: self.bounds.height/2)
        
        UIColor.black.set()
        circlePath.stroke()
        UIColor.systemRed.set()
        circlePath.fill()
        
        let lightPath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.midX, y: self.bounds.midY),
                                     radius: ((self.bounds.height/2)-8),
                                     startAngle: (180 * .pi) / 180,
                                     endAngle: (270 * .pi) / 180,
                                     clockwise: true)
        UIColor.black.set()
        lightPath.stroke()
    }
    
    // 코드로 view 인스턴스를 생성하기 위한 이니셜라이저
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 테두리 확인용 색
        self.backgroundColor = .yellow
        
        // 테두리 자르기
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.masksToBounds = true
    }
    
    // 인터페이스빌더, 스토리보드를 이용해 view를 생성할때 코드로 변환해주는 언아카이빙 과정이 필요한데, 이를 해주는 것이 required init
    // 결국에는 코드로 되어있어야 컴파일을 할 때 컴파일러가 인식할 수 있다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

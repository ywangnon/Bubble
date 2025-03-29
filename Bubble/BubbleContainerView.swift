//
//  BubbleContainerView.swift
//  Bubble
//
//  Created by Hansub Yoo on 3/30/25.
//

import UIKit

/// 버블을 자동으로 생성하고 움직이는 뷰
class BubbleContainerView: UIView {
    
    // MARK: - Configuration Properties
    /// 이미지로 버블을 나타내고 싶다면 설정 (nil이면 색으로 그린 버블 뷰 사용)
    var bubbleImage: UIImage?
    
    /// 버블 색상 (bubbleImage가 nil일 때만 반영)
    var bubbleColor: UIColor = .systemRed
    
    /// 버블 투명도
    var bubbleAlpha: CGFloat = 0.5
    
    /// 버블 생성 간격
    var bubbleSpawnInterval: TimeInterval = 0.1
    
    /// 버블 애니메이션(위로 올라가는) 총 지속 시간
    var bubbleAnimationDuration: TimeInterval = 4.0
    
    /// 버블 초기 크기 범위
    var bubbleMinSize: CGFloat = 100
    var bubbleMaxSize: CGFloat = 150
    
    /// 버블이 떠오를 최대 높이 비율(0 ~ 1). 1이면 뷰 전체 높이만큼 올라갈 수 있음
    var bubbleFloatHeightRatio: CGFloat = 0.4
    
    /// 내부에서 쓸 타이머
    private var bubbleTimer: Timer?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear // 배경을 투명하게 (혹은 원하는 색)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    deinit {
        // 혹시 뷰가 해제될 때 타이머가 남아 있으면 정리
        bubbleTimer?.invalidate()
        bubbleTimer = nil
    }
    
    // MARK: - Public Methods
    /// 버블 생성 시작
    func startGeneratingBubbles() {
        stopGeneratingBubbles() // 이미 돌고 있을 수 있는 타이머 정지
        bubbleTimer = Timer.scheduledTimer(
            timeInterval: bubbleSpawnInterval,
            target: self,
            selector: #selector(generateBubble),
            userInfo: nil,
            repeats: true
        )
    }
    
    /// 버블 생성 정지
    func stopGeneratingBubbles() {
        bubbleTimer?.invalidate()
        bubbleTimer = nil
    }
    
    // MARK: - Bubble Generation
    @objc private func generateBubble() {
        // 1) 생성될 버블 사이즈, 초기 위치 랜덤 결정
        let bubbleSize = CGFloat.random(in: bubbleMinSize...bubbleMaxSize)
        let bubbleX = CGFloat.random(in: 0...(bounds.width - bubbleSize))
        let bubbleY = bounds.height - bubbleSize
        
        // 2) Frame 생성
        let bubbleFrame = CGRect(x: bubbleX, y: bubbleY, width: bubbleSize, height: bubbleSize)
        
        // 3) 버블 뷰를 어떤 식으로 만들지 선택
        let bubble: UIView
        
        if let image = bubbleImage {
            // 3-1) 이미지 뷰로 버블 만들기
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.frame = bubbleFrame
            imageView.alpha = bubbleAlpha
            bubble = imageView
            
        } else {
            // 3-2) 커스텀 그리는 버블 뷰
            let customBubbleView = BubbleView(frame: bubbleFrame)
            customBubbleView.alpha = bubbleAlpha
            // BubbleView에 색을 주는 방식을 커스텀하려면,
            // BubbleView에 bubbleColor 등의 프로퍼티 추가 후 반영할 수도 있음
            // 여기서는 draw(_:) 안에서 systemRed 등을 기본으로 사용한다고 가정
            bubble = customBubbleView
        }
        
        // 4) Subview로 추가
        addSubview(bubble)
        
        // 5) 애니메이션: 위로 올라가고, 크기 변경, 투명도 변경 등
        UIView.animate(withDuration: bubbleAnimationDuration, delay: 0, options: []) {
            // y 좌표를 위로 랜덤 이동 (bubbleFloatHeightRatio 비율만큼)
            let maxFloatDistance = self.bounds.height * self.bubbleFloatHeightRatio
            bubble.frame.origin.y -= CGFloat.random(in: 0...maxFloatDistance)
            
            // x 좌표 랜덤 흔들림
            if Bool.random() {
                bubble.frame.origin.x += CGFloat.random(in: 0...80)
            } else {
                bubble.frame.origin.x -= CGFloat.random(in: 0...80)
            }
            
            // 크기를 살짝 키워주고
            bubble.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
            // 서서히 사라지기
            bubble.alpha = 0
        } completion: { _ in
            bubble.removeFromSuperview()
        }
    }
}


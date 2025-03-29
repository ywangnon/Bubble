//
//  ViewController.swift
//  Bubble
//
//  Created by Hansub Yoo on 2022/07/19.
//

import UIKit


class ViewController: UIViewController {
    
    // 타이머를 프로퍼티로 들고 있어서 필요 시 invalidate 가능
    private var bubbleTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        // 화면 보일 때마다 계속 생성하고 싶다면 viewDidAppear에서도 가능
        // 한 번만 시작할 거라면 viewDidLoad에서 시작
        bubbleTimer = Timer.scheduledTimer(timeInterval: 0.05,
                                           target: self,
                                           selector: #selector(bubbleAnimation),
                                           userInfo: nil,
                                           repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 화면 사라질 때 타이머 정지
        bubbleTimer?.invalidate()
        bubbleTimer = nil
    }
    
    @objc func bubbleAnimation() {
        // 버블의 시작 위치와 크기 결정
        let randomX = CGFloat.random(in: -100...self.view.bounds.width)
        let randomY = self.view.bounds.height - CGFloat.random(in: 100...200)
        let startSize: CGFloat = 150
        let bubbleFrame = CGRect(x: randomX, y: randomY, width: startSize, height: startSize)
        
        // 커스텀 버블 뷰 생성
        let bubbleView = BubbleView(frame: bubbleFrame)
        // 반투명도
        bubbleView.alpha = 0.5
        self.view.addSubview(bubbleView)
        
        // 애니메이션
        UIView.animate(withDuration: 4.0, delay: 0, options: []) {
            // y 좌표를 위로 올리기
            bubbleView.frame.origin.y -= CGFloat.random(in: 0...self.view.bounds.height / 4)
            
            // x 좌표 랜덤 이동
            if Bool.random() {
                bubbleView.frame.origin.x += CGFloat.random(in: 0...80)
            } else {
                bubbleView.frame.origin.x -= CGFloat.random(in: 0...80)
            }
            
            bubbleView.frame.size = CGSize(width: 200, height: 200)
            
            // 서서히 사라지기
            bubbleView.alpha = 0
        } completion: { _ in
            // 끝나면 뷰 제거
            bubbleView.removeFromSuperview()
        }
    }
}

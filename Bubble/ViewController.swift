//
//  ViewController.swift
//  Bubble
//
//  Created by Hansub Yoo on 2022/07/19.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 일정 시간 간격으로 계속해서 생성
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(bubbleAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func bubbleAnimation() {
        // 버블뷰 생성
        let xPosition = CGFloat.random(in: -100...self.view.bounds.width)
        let yPosition = self.view.bounds.height - CGFloat.random(in: 100...200)
        let bubbleView = UIImageView(frame: CGRect(origin: CGPoint(x: xPosition, y: yPosition), size: CGSize(width: 150, height: 150)))
        bubbleView.image = UIImage(named: "bubble")
        bubbleView.alpha = 0.5
        self.view.addSubview(bubbleView)
        
        UIView.animate(withDuration: 4, delay: 0, options: []) {
            // 버블뷰 이동 & 흐려짐
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.7) {
                bubbleView.frame.origin.y -= CGFloat.random(in: 0...self.view.bounds.height/4)
                
                if Bool.random() {
                    print("+x")
                    bubbleView.frame.origin.x += CGFloat.random(in: 0...80)
                } else {
                    print("-x")
                    bubbleView.frame.origin.x -= CGFloat.random(in: 0...80)
                }
                
                bubbleView.frame.size = CGSize(width: 200, height: 200)
                bubbleView.alpha = 0
            }
        } completion: { _ in
            // 버블뷰 삭제
            bubbleView.removeFromSuperview()
            print("animation done")
        }
    }
}


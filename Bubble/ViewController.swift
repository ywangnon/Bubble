//
//  ViewController.swift
//  Bubble
//
//  Created by Hansub Yoo on 2022/07/19.
//

import UIKit

class ViewController: UIViewController {
    
    private let bubbleContainer = BubbleContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 1) 버블 컨테이너 뷰를 추가하고, 프레임 설정
        // 예: 화면의 아래쪽 절반 정도만 차지하게
        // bubbleContainer.frame = CGRect(x: 0,
        //                                y: view.bounds.height / 2,
        //                                width: view.bounds.width,
        //                                height: view.bounds.height / 2)
        // bubbleContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(bubbleContainer)
        
        // 1-2) 오토레이아웃 설정
        bubbleContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bubbleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bubbleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bubbleContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bubbleContainer.heightAnchor.constraint(equalToConstant: 100) // 사이즈를 작게 정해도 동작
        ])
        
        // 2) 필요하면 설정값 변경
        bubbleContainer.bubbleColor = .systemGreen
        bubbleContainer.bubbleAlpha = 0.7
        bubbleContainer.bubbleSpawnInterval = 0.05
        bubbleContainer.bubbleAnimationDuration = 5.0
        
        // 만약 이미지를 쓰고 싶으면
        // bubbleContainer.bubbleImage = UIImage(named: "bubble")
        
        // 3) 버블 생성 시작
        bubbleContainer.startGeneratingBubbles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 화면에서 사라지면 버블 생성을 멈춤
        bubbleContainer.stopGeneratingBubbles()
    }
}

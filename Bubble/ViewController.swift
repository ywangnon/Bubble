//
//  ViewController.swift
//  Bubble
//
//  Created by Hansub Yoo on 2022/07/19.
//

import UIKit

class ViewController: UIViewController {

    let bubbleView = BubbleView(frame: CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 40, height: 40)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(bubbleView)
    }
}


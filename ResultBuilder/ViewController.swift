//
//  ViewController.swift
//  ResultBuilder
//
//  Created by Arc Lin on 2021/7/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let scrollView = ScrollableContainer(contents: [
//            RedView(),
//            BlueView(),
//            GreenView()
//        ])
        
//        let flag = 50
//        Int.random(in: 0...3)

        let result = build {
            print("a123")
            RedView()
            BlueView()
            GreenView()
            for _ in 0...2 {
                GreenView()
                BlueView()
            }
        }
        
        view.addSubview(result.build())
    }
    
    func build(@ScrollableViewBuilder content: () -> ViewBuilder) -> ViewBuilder {
        return content()
    }
}


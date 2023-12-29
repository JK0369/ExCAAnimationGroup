//
//  ViewController.swift
//  ExCaAnimationGroup
//
//  Created by 김종권 on 2023/12/29.
//

import UIKit

class ViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("show animation", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(showAnimation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let circleView = CircleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        circleView.backgroundColor = .blue
        view.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 100),
            circleView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc
    private func showAnimation() {
        /// 코드 참고:  https://developer.apple.com/documentation/quartzcore/caanimationgroup
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        
        let expandScale = CABasicAnimation()
        expandScale.keyPath = "transform"
        expandScale.valueFunction = CAValueFunction(name: CAValueFunctionName.scale)
        expandScale.fromValue = [1, 1, 1]
        expandScale.toValue = [3, 3, 3]
        
        let fadeAndScale = CAAnimationGroup()
        fadeAndScale.animations = [fadeOut, expandScale]
        fadeAndScale.duration = 1
        
        circleView.layer.add(fadeAndScale, forKey: "fade_and_scale")
    }
}

final class CircleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
    }
}

//
//  ViewController.swift
//  relatedAnimation
//
//  Created by Ekaterina Saveleva on 08.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Public properties
    
    let slider = UISlider()
    var animator = UIViewPropertyAnimator(duration: 0.6, curve: .linear)
  
    
    //MARK: Private properties
    
    private lazy var squareView: UIView = {
        let view = UIView(frame: CGRect(x: view.layoutMargins.left, y: 100, width: 100, height: 100))
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets(top: view.layoutMargins.top, left: 20, bottom: view.layoutMargins.bottom, right: 20)
        // slider
        slider.frame = CGRect(x: view.layoutMargins.left, y: 300, width: UIScreen.main.bounds.width - view.layoutMargins.left - view.layoutMargins.right, height: 30)
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.addTarget(self, action: #selector(moveFigure(_ :)), for: .valueChanged)
        
        setupView()
        
        animator.addAnimations {
            self.squareView.frame = CGRect(x: UIScreen.main.bounds.width - (self.squareView.frame.width * 1.5) - self.view.layoutMargins.right, y: 100, width: self.squareView.frame.width * 1.5, height: self.squareView.frame.height * 1.5)
            self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            self.slider.addTarget(self, action:#selector(self.startAnimation), for: [.touchUpOutside, .touchUpInside])
            self.animator.pausesOnCompletion = true
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layoutMarginsDidChange()
    }
    
    //MARK: - Public methods
    
    @objc func moveFigure(_ sender: UISlider!) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func startAnimation() {
        animator.startAnimation()
        slider.setValue(slider.maximumValue, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        view.addSubview(squareView)
        view.addSubview(slider)
    }

}





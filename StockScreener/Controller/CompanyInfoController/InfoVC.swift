//
//  InfoVC.swift
//  StockScreener
//
//  Created by Max Nechaev on 01.07.2021.
//

import UIKit

class InfoVC: UIViewController {
    
    let blackBackView = UIView()
    
    private let model: MostActiveElement
    
    init(model: MostActiveElement) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func moveFromCells() {
            
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            
            let setupGesture = UITapGestureRecognizer(target: self.blackBackView, action: #selector(handleDismiss))
            setupGesture.numberOfTapsRequired = 1
            setupGesture.numberOfTouchesRequired = 1
            blackBackView.addGestureRecognizer(setupGesture)
            
            print(model.companyName)
            
            blackBackView.frame = keyWindow.frame
            blackBackView.backgroundColor = .black
            blackBackView.alpha = 0
            view.backgroundColor = .secondarySystemBackground
            keyWindow.addSubview(blackBackView)

            UIView.animate(withDuration: 0.5) {
                self.blackBackView.alpha = 0.5
            }
            
            view.frame = CGRect(x: keyWindow.frame.width / 2 - 30, y: keyWindow.frame.height - 40, width: 40, height: 40)
            keyWindow.addSubview(view)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                //view.frame = keyWindow.frame
                self.view.frame = CGRect(x: 0, y: 200, width: keyWindow.frame.width, height: keyWindow.frame.height - 200)
                self.blackBackView.alpha = 0.5

            } completion: { (completedAnimation) in
                print("I've completed the animation")
            }
        }
        

    }
    
    @objc func handleDismiss() {
        print("handleDismiss handleDismiss handleDismiss")
    }
    
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//
//  InfoVC.swift
//  StockScreener
//
//  Created by Max Nechaev on 01.07.2021.
//

import UIKit

class InfoVC: UIViewController {
        
    private let model: MostActiveElement
    
    init(model: MostActiveElement) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

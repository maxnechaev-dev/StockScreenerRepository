//
//  ViewController.swift
//  StockScreener
//
//  Created by Max Nechaev on 08.06.2021.
//

import UIKit

final class MainViewController: UIViewController {
	private lazy var mainView = MainView(frame: .zero, segments: [Segment(title: "Trending"), Segment(title: "Favorite")])
	private let childControllersAssembly: (PageControllerOutput?) -> UIViewController

	init(childControllersAssembly: @escaping (PageControllerOutput?) -> UIViewController) {
		self.childControllersAssembly = childControllersAssembly
		super.init(nibName: nil, bundle: nil)
	}

	var onIndexChange:((_ selectedIndex: Int) -> Void)?

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	//MARK: - viewDidLoad
	override func loadView() {
		view = mainView
		mainView.delegate = self
	}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()

		let child = childControllersAssembly(self)
		addChild(child)
    }
    
    //MARK: - Настройка Navigation
    
    func setupNavigationController() {
        title = "Stock Screener"

        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

	override func addChild(_ childController: UIViewController) {
		super.addChild(childController)
		mainView.addChild(view: childController.view)
		childController.didMove(toParent: self)
	}
}

extension MainViewController: PageControllerOutput {
	func didSelectIndex(_ index: Int) {
		mainView.setSelectedIndex(index)
	}
}

extension MainViewController: MainViewDelegate {
	func userSelect(segment: Segment, at index: Int) {
		onIndexChange?(index)
	}
}

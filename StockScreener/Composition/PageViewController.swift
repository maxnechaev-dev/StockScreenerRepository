//
//  PageViewController.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.08.2021.
//

import UIKit

protocol PageControllerOutput: AnyObject {
	func didSelectIndex(_ index: Int)
}

class PageViewController: UIPageViewController {
	weak var output: PageControllerOutput?

	private let controllers: [UIViewController]

	init(controllers: [UIViewController],
		 style: UIPageViewController.TransitionStyle,
		 navigationOrientation: UIPageViewController.NavigationOrientation) {
		self.controllers = controllers
		super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		dataSource = self
		delegate = self
		guard !controllers.isEmpty else { return }
		setViewControllers([controllers[0]],
						   direction: .forward,
						   animated: false,
						   completion: nil)
	}

	func setCurrentIndex(_ index: Int) {
		setViewControllers([controllers[index]],
						   direction: .forward,
						   animated: false,
						   completion: nil)
	}
}


extension PageViewController: UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if let index = controllers.firstIndex(of: viewController), index > 0 {
			let newIndex = index - 1
			return controllers[newIndex]
		}
		return nil
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if let index = controllers.firstIndex(of: viewController), index < controllers.count - 1 {
			let newIndex = index + 1
			return controllers[newIndex]
		}
		return nil
	}

	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return controllers.count
	}
}


extension PageViewController: UIPageViewControllerDelegate {
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		guard finished && completed else {
			return
		}
		
	}
}

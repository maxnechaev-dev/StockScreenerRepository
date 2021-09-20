//
//  MainView.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.08.2021.
//

import UIKit

protocol MainViewDelegate: AnyObject {
	func userSelect(segment: Segment, at index: Int)
}

final class MainView: UIView {
	weak var delegate: MainViewDelegate?
	private let segmentedControl: UISegmentedControl
	private let containerView: UIView
	private let segments: [Segment]
	private var observation: NSKeyValueObservation?
	init(frame: CGRect, segments: [Segment]) {
		segmentedControl = UISegmentedControl(items: segments.map({ $0.title }))
		segmentedControl.selectedSegmentIndex = 0
		containerView = UIView()
		self.segments = segments
		super.init(frame: frame)
		setupViews()
		setupConstraints()
		observation = segmentedControl.observe(\.selectedSegmentIndex, options: .new, changeHandler: {
			[weak self] _, value in
			guard let self = self else {
				return
			}
			if let newValue = value.newValue {
				self.delegate?.userSelect(segment: self.segments[newValue], at: newValue)
			}
		})
	}

	private func setupViews() {
		addSubview(segmentedControl)
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
										segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			segmentedControl.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			segmentedControl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			segmentedControl.heightAnchor.constraint(equalToConstant: 40),

			containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
			containerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			containerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func addChild(view: UIView) {
		containerView.subviews.forEach({ $0.removeFromSuperview() })

		containerView.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: containerView.topAnchor),
			view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
			view.rightAnchor.constraint(equalTo: containerView.rightAnchor),
			view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
		])
	}

	func setSelectedIndex(_ index: Int) {
		guard index < segmentedControl.numberOfSegments else {
			return assert(false)
		}
		segmentedControl.selectedSegmentIndex = index
	}
}

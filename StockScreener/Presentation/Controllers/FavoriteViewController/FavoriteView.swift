//
//  FavoriteView.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.08.2021.
//

import UIKit

class FavoriteView: UIView {

	//MARK: - Создание collectionview

	lazy var collectionview: UICollectionView = {

		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionview.translatesAutoresizingMaskIntoConstraints = false
		collectionview.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.cellId)
		collectionview.backgroundColor = .secondarySystemBackground

		return collectionview
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCollectionview()
	}

	//MARK: - Разметка collectionview

	private func setupCollectionview() {
		self.addSubview(collectionview)
		collectionview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		collectionview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		collectionview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		collectionview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

//
//  TableViewHeader.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 11.12.22.
//

import UIKit

class HourInfoView: UIView {
    
    private var hours = [Hour]()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var seporator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.3
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(collectionView)
        addSubview(seporator)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 116),
            seporator.bottomAnchor.constraint(equalTo: bottomAnchor),
            seporator.leadingAnchor.constraint(equalTo: leadingAnchor),
            seporator.trailingAnchor.constraint(equalTo: trailingAnchor),
            seporator.heightAnchor.constraint(equalToConstant: 1)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HourInfoCell.self, forCellWithReuseIdentifier: HourInfoCell.reuseIdentifire)
        collectionView.backgroundColor = .clear
    }
    func setup(weather: Weather) {
        print(weather.forecast.forecastday.count)
        hours = weather.forecast.forecastday.first!.hour
        collectionView.reloadData()
    }
}

extension HourInfoView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourInfoCell.reuseIdentifire, for: indexPath) as? HourInfoCell else { fatalError()}
        cell.setupCell(hour: hours[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 70, height: 116)
    }
}

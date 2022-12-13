//
//  AdditionalForecastItemView.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 12.12.22.
//

import UIKit

class AdditionalForecastView: UIView {

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    private lazy var leftSide: AditionalForecastItem = {
        let view = AditionalForecastItem()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var rightSide: AditionalForecastItem = {
        let view = AditionalForecastItem()
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
        addSubview(stackView)
        addSubview(seporator)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            seporator.bottomAnchor.constraint(equalTo: bottomAnchor),
            seporator.leadingAnchor.constraint(equalTo: leadingAnchor),
            seporator.trailingAnchor.constraint(equalTo: trailingAnchor),
            seporator.heightAnchor.constraint(equalToConstant: 1)
        ])
        stackView.addArrangedSubview(leftSide)
        stackView.addArrangedSubview(rightSide)
        stackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            leftSide.heightAnchor.constraint(equalToConstant: 60),
            rightSide.heightAnchor.constraint(equalTo: leftSide.heightAnchor)
        ])
    }
    func setupLeftSide(top: String, lower: String) {
        leftSide.setup(top, lowerText: lower)
    }
    func setupRightSide(top: String, lower: String) {
        rightSide.setup(top, lowerText: lower)
    }
}


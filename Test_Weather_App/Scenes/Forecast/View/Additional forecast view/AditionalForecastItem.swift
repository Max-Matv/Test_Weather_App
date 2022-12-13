//
//  AditionalForecastItem.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 12.12.22.
//

import UIKit

class AditionalForecastItem: UIView {

    private lazy var topLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 13)
        view.alpha = 0.5
        return view
    }()
    private lazy var lowerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 28)
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
        addSubview(topLabel)
        addSubview(lowerLabel)
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lowerLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 1),
            lowerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lowerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    func setup(_ topText: String, lowerText: String) {
        topLabel.text = topText
        lowerLabel.text = lowerText
    }

}

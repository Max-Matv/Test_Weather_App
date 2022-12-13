//
//  ForecastDayView.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 12.12.22.
//

import UIKit

class ForecastDayView: UIView {

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
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
    }
    
    func setup(days: [ForecastDay]) {
        days.forEach { day in
            let forecastItem = ForecastDayViewElement()
            forecastItem.setup(forecastDay: day)
            forecastItem.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(forecastItem)
            forecastItem.heightAnchor.constraint(equalToConstant: 40).isActive = true
            forecastItem.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        }
        
    }

}

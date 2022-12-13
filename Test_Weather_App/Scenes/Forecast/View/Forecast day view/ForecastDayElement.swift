//
//  ForecastDayView.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 12.12.22.
//

import UIKit

class ForecastDayViewElement: UIView {

    private lazy var dayLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20)
        return view
    }()
    private lazy var conditionImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    private lazy var maxTempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20)
        return view
    }()
    private lazy var minTempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.alpha = 0.5
        view.font = UIFont.systemFont(ofSize: 20)
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
        addSubview(dayLabel)
        addSubview(conditionImage)
        addSubview(maxTempLabel)
        addSubview(minTempLabel)
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            conditionImage.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor),
            conditionImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            conditionImage.heightAnchor.constraint(equalToConstant: 30),
            conditionImage.widthAnchor.constraint(equalTo: conditionImage.heightAnchor),
            minTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            minTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: minTempLabel.leadingAnchor, constant: -20),
            maxTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setup(forecastDay: ForecastDay) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: forecastDay.date)!
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE"
        dayLabel.text = dateFormatter.string(from: date)
        conditionImage.image = UIImage(named: Icons.getIcon(condition: forecastDay.day.condition))
        maxTempLabel.text = String(Int(forecastDay.day.maxtempC))
        minTempLabel.text = String(Int(forecastDay.day.mintempC))
    }
}

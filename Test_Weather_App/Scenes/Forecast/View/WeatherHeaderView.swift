//
//  WeatherHeaderView.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 9.12.22.
//

import UIKit

class WeatherHeaderView: UIView {

    private lazy var city: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 34)
         label.textAlignment = .center
        return label
    }()
    private lazy var temp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 96)
        label.textAlignment = .center
        return label
    }()
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private lazy var temperatureRange: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    private lazy var seporator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.3
        return view
    }()
    var weather: Weather?
    private lazy var collapsedConstraints: [NSLayoutConstraint] = [
        city.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
        city.centerXAnchor.constraint(equalTo: centerXAnchor),
        conditionLabel.topAnchor.constraint(equalToSystemSpacingBelow: city.bottomAnchor, multiplier: 1),
        conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        conditionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
    ]
    private lazy var expandedConstraints: [NSLayoutConstraint] = [
        city.topAnchor.constraint(equalTo: topAnchor, constant: 40),
        city.centerXAnchor.constraint(equalTo: centerXAnchor),
        temp.topAnchor.constraint(equalToSystemSpacingBelow: city.bottomAnchor, multiplier: 1),
        temp.centerXAnchor.constraint(equalTo: centerXAnchor),
        conditionLabel.topAnchor.constraint(equalToSystemSpacingBelow: temp.bottomAnchor, multiplier: 1),
        conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        temperatureRange.topAnchor.constraint(equalToSystemSpacingBelow: conditionLabel.bottomAnchor, multiplier: 1),
        temperatureRange.centerXAnchor.constraint(equalTo: centerXAnchor),
        temperatureRange.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
    ]
    
    var expended: Bool = false {
        didSet {
            if expended {
                NSLayoutConstraint.deactivate(collapsedConstraints)
                NSLayoutConstraint.activate(expandedConstraints)
                expendedSettings()
            } else {
                NSLayoutConstraint.deactivate(expandedConstraints)
                NSLayoutConstraint.activate(collapsedConstraints)
                collapsedSettings()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func collapsedSettings() {
        guard let weather = weather else { return }
        temp.text = ""
        temperatureRange.text = ""
        let tempC = String("\(Int(weather.current.tempC))º")
        let condition = weather.current.condition.text
        conditionLabel.text = "\(tempC) | \(condition)"
    }
    private func setupView() {
        addSubview(city)
        addSubview(temp)
        addSubview(conditionLabel)
        addSubview(temperatureRange)
        setupSeporator()
        NSLayoutConstraint.activate(expandedConstraints)
    }
    private func setupSeporator() {
        addSubview(seporator)
        NSLayoutConstraint.activate([
            seporator.bottomAnchor.constraint(equalTo: bottomAnchor),
            seporator.leadingAnchor.constraint(equalTo: leadingAnchor),
            seporator.trailingAnchor.constraint(equalTo: trailingAnchor),
            seporator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setup(weather: Weather) {
        self.weather = weather
        city.text = weather.location.name
        expendedSettings()
    }
    private func expendedSettings() {
        guard let weather = weather else { return }
        temp.text = String("\(Int(weather.current.tempC))º")
        conditionLabel.text = weather.current.condition.text
        let maxTemp = String("\(Int(weather.forecast.forecastday.first?.day.maxtempC ?? 0))º")
        let minTemp = String("\(Int(weather.forecast.forecastday.first?.day.mintempC ?? 0))º")
        temperatureRange.text = "H:\(maxTemp) L:\(minTemp)"
    }
}

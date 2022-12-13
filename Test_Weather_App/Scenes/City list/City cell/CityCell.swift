//
//  CityCell.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 7.12.22.
//

import UIKit

class CityCell: UITableViewCell {
    //MARK: - Views
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()
    private lazy var conditionImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup cell
    func setupCell(weather: Weather) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: weather.location.localtime)!
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: date)
        cityLabel.text = weather.location.name
        temperatureLabel.text = String("\(Int(weather.current.tempC))º")
        conditionImage.image = UIImage(named: Icons.getIcon(condition: weather.current.condition))
        conditionImage.contentMode = .scaleToFill
    }
    func setupSingleCell(weather: Weather) {
        cityLabel.text = "My location"
        timeLabel.text = weather.location.name
        temperatureLabel.text = String("\(Int(weather.current.tempC))º")
        conditionImage.image = UIImage(named: Icons.getIcon(condition: weather.current.condition))
        conditionImage.contentMode = .scaleToFill
    }
    //MARK: - Setup View
    private func setup() {
        addSubview(timeLabel)
        addSubview(cityLabel)
        addSubview(conditionImage)
        addSubview(temperatureLabel)
        backgroundColor = .clear
        timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: cityLabel.topAnchor, constant: -5).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        cityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: conditionImage.leadingAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: cityLabel.heightAnchor, multiplier: 0.4).isActive = true
        conditionImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        conditionImage.widthAnchor.constraint(equalTo: conditionImage.heightAnchor, multiplier: 1.0/1.0).isActive = true
        conditionImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        conditionImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 50).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

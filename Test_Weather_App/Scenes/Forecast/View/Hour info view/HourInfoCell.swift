//
//  TableViewHeaderCell.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 11.12.22.
//

import UIKit

class HourInfoCell: UICollectionViewCell {
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    private lazy var conditionIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        addSubview(timeLabel)
        addSubview(conditionIcon)
        addSubview(tempLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 12),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionIcon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 9),
            conditionIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionIcon.widthAnchor.constraint(equalToConstant: 30),
            conditionIcon.heightAnchor.constraint(equalTo: conditionIcon.widthAnchor),
            tempLabel.topAnchor.constraint(equalTo: conditionIcon.bottomAnchor, constant: 8),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tempLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -15)
        ])
        backgroundColor = .clear
    }
    
    func setupCell(hour: Hour) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: hour.time)!
        dateFormatter.dateFormat = "HH a"
        timeLabel.text = dateFormatter.string(from: date)
        conditionIcon.image = UIImage(named: Icons.getIcon(condition: hour.condition))
        tempLabel.text = String("\(Int(hour.tempC))º")
    }
}

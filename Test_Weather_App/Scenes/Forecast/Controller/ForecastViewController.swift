//
//  ForecastViewController.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 9.12.22.
//

import UIKit

class ForecastViewController: UIViewController {
    //MARK: - Properties
    var weather: Weather?
    //MARK: - Views
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var headerView: WeatherHeaderView = {
        let view = WeatherHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var scrollview: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = false
        return view
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hourView: HourInfoView = {
        let view = HourInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var forecastDayView: ForecastDayView = {
        let view = ForecastDayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    //MARK: - Setup View Controller
    private func setupViewController() {
        view.backgroundColor = UIColor(named: "screen2_background")
        setupHeaderView()
        setupScrollview()
        setupStackView()
        setupBackButton()
        setupGesture()
    }
    
    //MARK: - Setup back button
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor, multiplier: 1).isActive = true
    }
    @objc
    private func backPressed() {
        print("pressed")
        dismiss(animated: true)
    }
    //MARK: - Setup Scroll view
    private func setupScrollview() {
        view.addSubview(scrollview)
        scrollview.delegate = self
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    //MARK: - Setup Stack view
    private func setupStackView() {
        scrollview.addSubview(stackView)
        stackView.axis = .vertical
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollview.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor)
        ])
        stackView.addArrangedSubview(hourView)
        stackView.addArrangedSubview(forecastDayView)
        guard let weather = weather else { return }
        hourView.setup(weather: weather)
        forecastDayView.setup(days: weather.forecast.forecastday)
        forecastDayView.widthAnchor.constraint(equalTo: scrollview.widthAnchor).isActive = true
        hourView.heightAnchor.constraint(equalToConstant: 116).isActive = true
        hourView.widthAnchor.constraint(equalTo: scrollview.widthAnchor).isActive = true
        setupAdditionalViews()
    }
    //MARK: - Setup Gesture
    private func setupGesture() {
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        downGesture.direction = .down
        view.addGestureRecognizer(downGesture)
    }
    @objc
    private func swipeDown(_ sender: UISwipeGestureRecognizer) {
        headerView.expended = true
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    //MARK: - Setup addition views
    private func setupAdditionalViews() {
        let daytimeView = AdditionalForecastView()
        let chanceOfRain = AdditionalForecastView()
        let wind = AdditionalForecastView()
        let presssure = AdditionalForecastView()
        let visivility = AdditionalForecastView()
      
        stackView.addArrangedSubview(daytimeView)
        stackView.addArrangedSubview(chanceOfRain)
        stackView.addArrangedSubview(wind)
        stackView.addArrangedSubview(presssure)
        stackView.addArrangedSubview(visivility)
        guard let weather = weather else { return }
        daytimeView.setupLeftSide(top: "SUNRISE", lower: weather.forecast.forecastday.first!.astro.sunrise)
        daytimeView.setupRightSide(top: "SUNSET", lower: weather.forecast.forecastday.first!.astro.sunset)
        chanceOfRain.setupLeftSide(top: "CHANCE OF RAIN", lower:" \(String(weather.forecast.forecastday.first!.dailyChanceOfRain ?? 0))%")
        chanceOfRain.setupRightSide(top: "HUMIDITY", lower: "\(String(weather.current.humidity))%")
        wind.setupLeftSide(top: "WIND", lower: "\(String(weather.current.windKph)) km/hr")
        wind.setupRightSide(top: "FEELS LIKE", lower: "\(String(weather.current.feelslikeC))º")
        presssure.setupLeftSide(top: "PRECIPITATION", lower: "\(String(Int(weather.current.precipMm))) cm")
        presssure.setupRightSide(top: "PRESSURE", lower: "\(String(weather.current.pressureMB)) hPa")
        visivility.setupLeftSide(top: "VISIBILITY", lower: "\(String(weather.current.visKM)) km")
        visivility.setupRightSide(top: "UV INDEX", lower: String(weather.current.uv))
        NSLayoutConstraint.activate([
            daytimeView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            chanceOfRain.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            wind.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            presssure.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            visivility.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            daytimeView.heightAnchor.constraint(equalToConstant: 60),
            chanceOfRain.heightAnchor.constraint(equalToConstant: 60),
            wind.heightAnchor.constraint(equalToConstant: 60),
            presssure.heightAnchor.constraint(equalToConstant: 60),
            visivility.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    //MARK: - Setup header view
    private func setupHeaderView() {
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        guard let weather = weather else { return }
        headerView.setup(weather: weather)
    }
}

extension ForecastViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y > 30 {
            headerView.expended = false
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
   
}

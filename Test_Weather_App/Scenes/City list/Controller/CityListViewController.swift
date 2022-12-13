//
//  CityListViewController.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 6.12.22.
//

import UIKit
import CoreLocation

protocol CityListControllerProtocol: AnyObject {
    func weatherRequest(with response: [Weather])
    func weatherRequestByCoordinates(with response: Weather)
}

class CityListViewController: UIViewController {
    //MARK: - Properties
    var viewModel: CitylistProtocol?
    private var cityWeather: [Weather] = []
    private let locationManager = CLLocationManager()
    private var isCoordinatesDetermined: Bool = false
    private var filteredData: [Weather] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchBar.isUserInteractionEnabled && !searchBarIsEmpty
    }
    
    //MARK: - Views
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor(named: "screen1_background")
        searchBar.placeholder = "Search"
        searchBar.searchTextField.textColor = .white
        return searchBar
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    private lazy var currentCity: CityCell = {
        let view = CityCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setCurrentLocation()
        viewModel?.addWeatherRequest(Citys.citys)
    }
    
    //MARK: - Setup Controller
    private func setupController() {
        locationManager.delegate = self
        view.backgroundColor = UIColor(named: "screen1_background")
        view.addSubview(headerLabel)
        view.addSubview(searchBar)
        view.addSubview(currentCity)
        view.addSubview(tableView)
        setupLabel()
        setupSearchBar()
        setupCurrentCityView()
        setupTableView()
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.reuseIdentifire)
        navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    //MARK: - Filter content for text
    private func filterContentForSearchText(_ searchText: String) {
        filteredData = cityWeather.filter({ (weather: Weather) -> Bool in
            return weather.location.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    //MARK: - Set current location
    private func setCurrentLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 1000
    }
    
    //MARK: - Setup Header label
    private func setupLabel() {
        headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerLabel.font = UIFont.systemFont(ofSize: 34)
        headerLabel.text = "Weather"
        headerLabel.textColor = .white
    }
    //MARK: - Setup Search bar
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    //MARK: - Setup Table view
    private func setupTableView() {
        tableView.topAnchor.constraint(equalTo: currentCity.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    //MARK: - Setup Current City view
    private func setupCurrentCityView() {
        currentCity.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        currentCity.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currentCity.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        currentCity.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
//MARK: - Search bar delegate
extension CityListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
}
//MARK: - Location manager delegate
extension CityListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.last?.coordinate else { return }
        viewModel?.addRequestByCoordinates(lat: coordinates.latitude, lon: coordinates.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined,
           status != .denied,
           status != .restricted {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
//MARK: City list controller protocol functions
extension CityListViewController: CityListControllerProtocol {
    func weatherRequestByCoordinates(with response: Weather) {
        currentCity.setupSingleCell(weather: response)
        isCoordinatesDetermined = true
    }
    
    func weatherRequest(with response: [Weather]) {
        print(response.count)
        cityWeather = response
        tableView.reloadData()
    }
}
//MARK: - Table view data source / delegate
extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredData.count
        } else {
           return  cityWeather.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseIdentifire, for: indexPath) as? CityCell else { fatalError() }
        var weather: Weather
        if isFiltering {
            weather = filteredData[indexPath.row]
        } else {
            weather = cityWeather[indexPath.row]
        }
        cell.setupCell(weather: weather)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather: Weather
        if isFiltering {
            weather = filteredData[indexPath.row]
        } else {
            weather = cityWeather[indexPath.row]
        }
        let vc = ForecastViewController()
        vc.weather = weather
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        currentCity.frame.height
    }
    
}

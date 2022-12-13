//
//  CityListViewModel.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 7.12.22.
//

import Foundation
import Alamofire

protocol CitylistProtocol {
    func addWeatherRequest(_ citys: [String])
    func addRequestByCoordinates(lat: Double, lon: Double)
}

class CityListViewModel: CitylistProtocol {
    //MARK: - Propeties
    private weak var viewController: CityListControllerProtocol?
    private var weather: [Weather] = []
    
    init(viewController: CityListControllerProtocol) {
        self.viewController = viewController
    }
    //MARK: - Add request for main page
    func addWeatherRequest(_ citys: [String]) {
        let group = DispatchGroup()
        for city in citys {
            group.enter()
            addSingleRequest(city: city) { weather, error in
                guard let response = weather else {
                    group.leave()
                    print("\(city) fail")
                    return
                }
                print("\(response.location.name) is loaded")
                self.weather.append(response)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.viewController?.weatherRequest(with: self.weather)
        }
    }
    //MARK: - Add single request
    private func addSingleRequest(city: String, completition: @escaping (Weather?, Error?) -> Void) {
        let cityForURL = city.replacingOccurrences(of: " ", with: "%20")
        let weatherUrl = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=9ca01b9369ff4c158e192827222306&q=\(cityForURL)&days=3&aqi=no&alerts=no")!
        AF.request(weatherUrl).validate(statusCode: 200..<300).responseDecodable(of: Weather.self, queue: .global(qos: .utility)) { response in
            guard let data = response.data else { return }
            do {
                let weatherResponse = try JSONDecoder().decode(Weather.self, from: data)
                completition(weatherResponse, nil)
            } catch {
                completition(nil, error)
            }
        }
    }
    //MARK: - Add single request by coordinates
    func addRequestByCoordinates(lat: Double, lon: Double) {
        let coordinates: String = "\(String(lat)),\(String(lon))"
        let weatherUrl = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=9ca01b9369ff4c158e192827222306&q=\(coordinates)&days=3&aqi=no&alerts=no")!
        AF.request(weatherUrl).validate().responseDecodable(of: Weather.self, queue: .global(qos: .utility)) { response in
            guard let data = response.data else { return }
            do {
                let weatherResponse = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    self.viewController?.weatherRequestByCoordinates(with: weatherResponse)
                }
            } catch {
                print("error")
            }
        }
    }
}

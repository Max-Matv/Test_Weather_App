//
//  Icons.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 9.12.22.
//

import Foundation

class Icons {
    static func getIcon(condition: Condition) -> String {
        switch condition.code {
        case 1000:
            return "IconWeather-1a"
        case 1003:
            return "IconWeather-2a"
        case 1006:
            return "IconWeather-3a"
        case 1063:
            return "IconWeather-4a"
        case 1276:
            return "IconWeather-5a"
        case 1072:
            return "IconWeather-7a"
        case 1219:
            return "image2"
        default:
            return "IconWeather-3a"
        }
    }
}

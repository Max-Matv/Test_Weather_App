
import Foundation

struct Weather: Decodable {
    
    let location: Location
    let current: Current
    let forecast: Forecast
    
}

struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtime: String
    let localtimeEpoch: Int

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtime
        case localtimeEpoch = "localtime_epoch"
    }
}

struct Current: Decodable {
    let lastUpdated: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let humidity: Int
    let windKph: Double
    let feelslikeC: Double
    let precipMm: Double
    let pressureMB: Int
    let visKM: Double
    let uv: Int
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case humidity
        case windKph = "wind_kph"
        case feelslikeC = "feelslike_c"
        case precipMm = "precip_mm"
        case pressureMB = "pressure_mb"
        case visKM = "vis_km"
        case uv
    }
}

struct Condition: Decodable {
    let text: String
    let icon: String
    let code: Int
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
    
}

struct ForecastDay: Decodable {
    let date: String
    let day: Day
    let astro: Astro
    let hour: [Hour]
    let dailyChanceOfRain: Int?
    let dailyChanceOfSnow: Int?
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case astro
        case hour
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyChanceOfSnow = "daily_chance_of_snow"
    }
}

struct Day: Decodable {
    let maxtempC: Double
    let mintempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

struct Astro: Decodable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
}

struct Hour: Decodable {
    let time: String
    let tempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}


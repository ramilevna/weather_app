
import Foundation
import CoreLocation
class WeatherManager{
    func getCurrentWeather(latitude: CLLocationDegrees,longitude:CLLocationDegrees) async throws -> ResponceBody{
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("ad9a96341b7098b165d126e6d8bc5e6a")&units=metric") else{ fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        let (data, responce) =  try await URLSession.shared.data(for: urlRequest)
        guard (responce as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        let decodedData = try JSONDecoder().decode(ResponceBody.self, from: data)
        return decodedData
    }
}
struct ResponceBody: Decodable{
    var coord: CoordinatesResponce
    var weather: [WeatherResponce]
    var main: MainResponce
    var name: String
    var wind: WindResponce
    
    struct CoordinatesResponce: Decodable{
        var lon: Double
        var lat: Double
        
    }
    struct WeatherResponce: Decodable{
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    struct MainResponce: Decodable{
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    struct WindResponce: Decodable{
        var speed: Double
        var deg: Double
    }
}


import UIKit
import Freddy

class FreddyWeatherViewController: WeatherViewController {
    
override func loadWeather() {
    if let data = getDataFromLocalJSONFileWithName("weather") {
        do {
            let json = try JSON(data: data)
            temperature = try json.double("currently", "temperature")
            summary = try json.string("currently", "summary")
        } catch {
            presentError(error)
        }
    } else {
        presentError("Could not load data file.")
    }
}
    
}

import UIKit
import Freddy

class NativeWeatherViewController: WeatherViewController {

    override func loadWeather() {
        if let data = getDataFromLocalJSONFileWithName("weather") {
            do {
                if let weatherDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject],
                    let currentlyDictionary = weatherDictionary["currently"] as? [String: AnyObject],
                    let temperature = currentlyDictionary["temperature"] as? Double,
                    let summary = currentlyDictionary["summary"] as? String {
                        self.temperature = temperature
                        self.summary = summary
                } else {
                    presentError("Could not parse JSON.")
                }
            } catch {
                presentError(error)
            }
        } else {
            presentError("Could not load data file.")
        }
    }

}

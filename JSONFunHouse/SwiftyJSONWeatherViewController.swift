import UIKit
import SwiftyJSON

class SwiftyJSONWeatherViewController: WeatherViewController {
    
    override func loadWeather() {
        if let data = getDataFromLocalJSONFileWithName("weather") {
            let json = JSON(data: data)
            
            if let temperature = json["currently"]["temperature"].double {
                self.temperature = temperature
            } else {
                presentError(json["currently"]["temperature"].error)
            }
            
            if let summary = json["currently"]["summary"].string {
                self.summary = summary
            } else {
                presentError(json["currently"]["summary"].error)
            }
        }
        
    }
    
}

import UIKit
import Freddy

class WeatherViewController: UIViewController {
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    var temp = -99.9
    var summary = "Unknown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func loadWeather() {
        let data = getData()
        do {
            let json = try JSON(data: data)
            let success = try json.bool("success")
            // do something with `success`
        } catch {
            // do something with the error
        }
    }
    
    private func getData() -> NSData? {
        if let dataURL = NSBundle.mainBundle().URLForResource("weather", withExtension: "json") {
            if let data = NSData(contentsOfURL: dataURL) {
                return data
            }
        }
        return nil
    }
}

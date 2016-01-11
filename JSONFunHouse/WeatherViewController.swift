import UIKit
import Freddy

class WeatherViewController: UIViewController {
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    var temperature: Double = -99.9
    var summary = "Unknown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeather()
    }
    
    override func viewWillAppear(animated: Bool) {
        temperatureLabel.text = String(format:"%.1f°", temperature)
        summaryLabel.text = summary
    }
    
    private func loadWeather() {
        if let data = getData() {
            do {
                let json = try JSON(data: data)
                temperature = try json.double("currently", "temperature")
                summary = try json.string("currently", "summary")
            } catch {
                presentError(error)
            }
        }
    }
    
    private func getData() -> NSData? {
        if let dataURL = NSBundle.mainBundle().URLForResource("weather", withExtension: "json") {
            return NSData(contentsOfURL: dataURL)
        }
        return nil
    }
}

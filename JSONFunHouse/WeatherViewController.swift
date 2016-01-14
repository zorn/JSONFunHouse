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
        super.viewWillAppear(animated)
        temperatureLabel.text = String(format:"%.1f°", temperature)
        summaryLabel.text = summary
    }
    
    func loadWeather() {
        fatalError("loadWeather() should be implemented by a subclass")
    }
    
}

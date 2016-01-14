import UIKit

class MenuViewController : UITableViewController {
    
    struct MenuSection {
        let sectionType: SectionType
        let items: [MenuItem]
    }
    
    struct MenuItem {
        let name: String
        let storyboardID: String
        let dataFilename: String
    }
    
    enum SectionType: String {
        case Weather = "Weather (Simple)"
        case Meeting = "Meeting (Mapping)"
        case Freddy = "Firefly (Freddy)"
        case SwiftyJSON = "Firefly (SwiftyJSON)"
        case Argo = "Firefly (Argo)"
    }
    
    var sections = [MenuSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMenu()
    }
    
    private func loadMenu() {
        
        let nativeWeather = MenuItem(name: "Native Swift", storyboardID: "NativeWeatherViewController", dataFilename: "weather")
        let swiftyJSONWeather = MenuItem(name: "Swifty JSON", storyboardID: "SwiftyJSONWeatherViewController", dataFilename: "weather")
        let freddyWeather = MenuItem(name: "Freddy", storyboardID: "FreddyWeatherViewController", dataFilename: "weather")
        let weatherSection = MenuSection(sectionType: .Weather, items: [nativeWeather, swiftyJSONWeather, freddyWeather])

        let freddyMeeting = MenuItem(name: "Meeting List", storyboardID: "FreddyMeetingListViewConroller", dataFilename: "meetings")
        let meetingSection = MenuSection(sectionType: .Meeting, items: [freddyMeeting])
        
        let freddyMenu1 = MenuItem(name: "Cast Demo", storyboardID: "FreddyCastDemoViewController", dataFilename: "firefly")
        let freddyMenu2 = MenuItem(name: "Cast Demo (Missing Key)", storyboardID: "FreddyCastDemoViewController", dataFilename: "firefly-missing-key")
        let freddyMenu3 = MenuItem(name: "Cast Demo (Bad Type)", storyboardID: "FreddyCastDemoViewController", dataFilename: "firefly-wrong-type")
        let freddySection = MenuSection(sectionType: .Freddy, items: [freddyMenu1, freddyMenu2, freddyMenu3])
        
        let swiftyMenu1 = MenuItem(name: "Cast Demo", storyboardID: "SwiftyJSONCastDemoViewController", dataFilename: "firefly")
        let swiftyMenu2 = MenuItem(name: "Cast Demo (Missing Key)", storyboardID: "SwiftyJSONCastDemoViewController", dataFilename: "firefly-missing-key")
        let swiftyMenu3 = MenuItem(name: "Cast Demo (Bad Type)", storyboardID: "SwiftyJSONCastDemoViewController", dataFilename: "firefly-wrong-type")
        let swiftySection = MenuSection(sectionType: .SwiftyJSON, items: [swiftyMenu1, swiftyMenu2, swiftyMenu3])

        let argoMenu1 = MenuItem(name: "Cast Demo", storyboardID: "ArgoCastDemoViewController", dataFilename: "firefly")
        let argoMenu2 = MenuItem(name: "Cast Demo (Missing Key)", storyboardID: "ArgoCastDemoViewController", dataFilename: "firefly-missing-key")
        let argoMenu3 = MenuItem(name: "Cast Demo (Bad Type)", storyboardID: "ArgoCastDemoViewController", dataFilename: "firefly-wrong-type")
        let argoSection = MenuSection(sectionType: .Argo, items: [argoMenu1, argoMenu2, argoMenu3])
        
        self.sections = [weatherSection, meetingSection, freddySection, swiftySection, argoSection]
    }
}

extension MenuViewController { // UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionType.rawValue
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menuItem = sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic", forIndexPath: indexPath)
        cell.textLabel!.text = menuItem.name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = sections[indexPath.section]
        let menuItem = section.items[indexPath.row]
        switch section.sectionType {
        case .Freddy, .SwiftyJSON, .Argo:
            var vc = self.storyboard!.instantiateViewControllerWithIdentifier(menuItem.storyboardID) as! DataURLLoadable
            vc.dataURL = NSBundle.mainBundle().URLForResource(menuItem.dataFilename, withExtension: "json")
            showViewController(vc as! UIViewController, sender: self)
        case .Weather, .Meeting:
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier(menuItem.storyboardID) 
            showViewController(vc, sender: self)
        }
    }
}

import UIKit
import SwiftyJSON

class SwiftyJSONCastDemoViewController: UITableViewController, DataURLLoadable {
    
    var dataURL: NSURL?
    var castList = [FireflyCastMember]() {
        didSet {
            // sort the cast list by name
            self.castList = self.castList.sort({ (m1, m2) -> Bool in
                return m1.name < m2.name
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCastData()
    }
    
    private func loadCastData() {
        if let data = getDataFromFileURL(self.dataURL) {
            let json = JSON(data: data)
            // FIXME: I want to be fair to SwiftyJSON -- is there a nicer way to chain these?
            for (_,subJson) in json {
                if let name = subJson["character"].string {
                    if let biography = subJson["bio"].string {
                        let castMember = FireflyCastMember(name: name, biography: biography)
                        castList.append(castMember)
                    } else {
                        // This sadly will be nil, see:
                        // https://github.com/SwiftyJSON/SwiftyJSON/issues/433
                        presentError(subJson["bio"].error)
                    }
                } else {
                    presentError(subJson["character"].error)
                }
            }
        } else {
            presentError("Could not load data file.")
        }
    }
    
}

extension SwiftyJSONCastDemoViewController { // UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.castList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic", forIndexPath: indexPath)
        let castMember = self.castList[indexPath.row]
        cell.textLabel?.text = castMember.name
        return cell
    }
    
}
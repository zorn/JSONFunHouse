import UIKit
import Freddy

class FreddyCastDemoViewController: UITableViewController, DataURLLoadable {
    
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
            do {
                let json = try JSON(data: data)
                self.castList = try json.array().map(FireflyCastMember.init)
            } catch {
                presentError(error)
            }
        } else {
            presentError("Could not load data file.")
        }
    }
    
}

extension FreddyCastDemoViewController { // UITableViewDataSource
    
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
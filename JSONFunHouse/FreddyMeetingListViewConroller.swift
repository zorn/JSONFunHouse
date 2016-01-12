import UIKit
import Freddy

class FreddyMeetingListViewConroller: UITableViewController, DataURLLoadable {
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "M/dd"
        return formatter
    }()
    var dataURL: NSURL?
    var meetingList = [Meeting]() {
        didSet {
            self.meetingList = self.meetingList.sort({ (m1, m2) -> Bool in
                return m1.date.compare(m2.date) == NSComparisonResult.OrderedAscending
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMeetingData()
    }
    
    private func loadMeetingData() {
        if let data = getDataFromLocalJSONFileWithName("meetings") {
            do {
                let json = try JSON(data: data)
                self.meetingList = try json.array().map(Meeting.init)
            } catch {
                presentError(error)
            }
        } else {
            presentError("Could not load data file.")
        }
    }
    
}

extension FreddyMeetingListViewConroller { // UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetingList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RightDetail", forIndexPath: indexPath)
        let meeting = self.meetingList[indexPath.row]
        let dateDescription = dateFormatter.stringFromDate(meeting.date)
        cell.textLabel?.text = "\(meeting.title), \(dateDescription)"
        cell.detailTextLabel?.text = "\(meeting.rsvpCount)"
        return cell
    }
    
}
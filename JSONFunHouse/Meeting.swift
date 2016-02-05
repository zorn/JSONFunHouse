import Foundation
import Freddy

struct Meeting {
    
    enum Error: ErrorType {
        case DateParseErrorFromString(String)
    }
    
    let title: String
    let date: NSDate
    let rsvpCount: Int
    
    init(title: String, date: NSDate, rsvpCount: Int) {
        self.title = title
        self.date = date
        self.rsvpCount = rsvpCount
    }
    
}

extension Meeting: JSONDecodable {
    init(json value: JSON) throws {
        title = try value.string("title")
        rsvpCount = try value.int("rsvp_count")
        
        let dateString = try value.string("date")
        let df = NSDateFormatter()
        // 2016-03-10T18:30:00-0500
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        if let parsedDate = df.dateFromString(dateString) {
            date = parsedDate
        } else {
            throw Error.DateParseErrorFromString(dateString)
        }
    }
}


extension Meeting: JSONEncodable {
    internal func toJSON() -> JSON {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return .Dictionary(
            [
                "title": .String(title),
                "rsvp_count": .Int(rsvpCount),
                "date": .String(df.stringFromDate(date))
            ]
        )
    }
}


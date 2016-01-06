import Foundation
import Freddy

struct FireflyCastMember {
    
    let name: String
    let biography: String
    
    init(name: String, biography: String) {
        self.name = name
        self.biography = biography
    }
    
}

extension FireflyCastMember: JSONDecodable {
    init(json value: JSON) throws {
        name = try value.string("character")
        biography = try value.string("bio")
    }
}

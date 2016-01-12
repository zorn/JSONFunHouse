import Foundation
import Freddy

extension FireflyCastMember: JSONDecodable {
    init(json value: JSON) throws {
        name = try value.string("character")
        biography = try value.string("bio")
    }
}
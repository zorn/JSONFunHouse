import Foundation
import Argo
import Curry

extension FireflyCastMember: Decodable {
    static func decode(j: JSON) -> Decoded<FireflyCastMember> {
        return curry(FireflyCastMember.init)
            <^> j <| "character"
            <*> j <| "bio"
    }
}

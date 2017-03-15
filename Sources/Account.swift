import Foundation

extension Wistia {
    
    public struct Account {
        
        /// Numeric id of the account
        public let accountID: Int
        
        /// Account name
        public let name: String
        
        /// Account's main Wistia URL (e.g. http://brendan.wistia.com) as a String
        internal let accountURLString: String
        
        /// Account's main Wistia URL (e.g. http://brendan.wistia.com)
        public var accountURL: URL {
            return URL(string: accountURLString)!
        }
        
        /// The total number of medias in this account
        public let mediaCount: Int
        
    }

}

extension Wistia.Account: JSONSerializable {
    
    public init?(json: JSONDictionary) {
        
        guard let accountID = json["id"] as? Int,
            let name = json["name"] as? String,
            let url = json["url"] as? String,
            let mediaCount = json["mediaCount"] as? Int
            else { return nil }
        self.accountID = accountID
        self.name = name
        self.accountURLString = url
        self.mediaCount = mediaCount
        
    }
    
}

extension Wistia.Account {
    
    internal static var details: Resource<Wistia.Account> {
        return try! Resource<Wistia.Account>(url: URL(route: .account), method: .get, parseJSON: { json -> Wistia.Account? in
            if let json = json as? JSONDictionary {
                return Wistia.Account(json: json)
            } else {
                return nil
            }
        })
    }
    
}

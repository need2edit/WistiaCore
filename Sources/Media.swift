import Foundation

extension Wistia {
    public struct Media {
        
        public let hashedId: String
        public let name: String
        public let description: String
        
        public let section: String?
        
        public let assets: [Asset]
        
        public struct Asset {
            let url: String
            let contentType: String
            let type: String
            let width: Int
            let height: Int
        }
        
    }
}

extension Wistia.Media: JSONSerializable {
    public init?(json: JSONDictionary) {
        guard let hashedId = json["hashedId"] as? String ?? json["hashed_id"] as? String,
            let name = json["name"] as? String,
            let description = json["description"] as? String
            else { return nil }
        self.hashedId = hashedId
        self.name = name
        self.description = description
        
        let assetInfo = json["assets"] as? [JSONDictionary] ?? []
        let assets = assetInfo.flatMap { Asset(json: $0) }
        
        self.assets = assets
        
        self.section = json["section"] as? String
    }
}

extension Wistia.Media.Asset: JSONSerializable {
    public init?(json: JSONDictionary) {
        guard let url = json["url"] as? String,
            let contentType = json["contentType"] as? String,
            let type = json["type"] as? String,
            let width = json["width"] as? Int,
            let height = json["height"] as? Int
            else { return nil }
        self.url = url
        self.type = type
        self.contentType = contentType
        self.width = width
        self.height = height
    }
}


extension Wistia.Media {
    
    internal static var list = try! Resource<[Wistia.Media]>(
        url: URL(route: .medias),
        parseElement: Wistia.Media.init
    )
    
    internal func show(hashedId: String) -> Resource<Wistia.Media> {
        return try! Resource<Wistia.Media>(url: URL(route: .media(hashedId)), method: .get, parseJSON: { json -> Wistia.Media? in
            if let json = json as? JSONDictionary {
                return Wistia.Media(json: json)
            } else {
                return nil
            }
        })
    }
}

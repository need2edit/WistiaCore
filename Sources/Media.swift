import Foundation

extension Wistia {
    public struct Media {
        
        let hashedId: String
        let name: String
        let description: String
        
        let assets: [Asset]
        
        public struct Asset {
            let url: String
            let contentType: String
            let type: String
            let width: Int
            let height: Int
        }
        
    }
}

extension Wistia.Media {
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
    }
}

extension Wistia.Media.Asset {
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
    static var list = try! Resource<[Wistia.Media]>(
        url: URL(route: .medias),
        parseElement: Wistia.Media.init
    )
}

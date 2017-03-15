import Foundation

extension Wistia {
    public struct Project {
        
        public let hashedId: String
        public let name: String
        public let description: String
        public let medias: [Media]?
        public var mediaCount: Int
        
    }
}

extension Wistia.Project: JSONSerializable {
    public init?(json: JSONDictionary) {
        guard let hashedId = json["hashedId"] as? String,
            let name = json["name"] as? String,
            let description = json["description"] as? String,
            let mediaCount = json["mediaCount"] as? Int
            else { return nil }
        self.hashedId = hashedId
        self.name = name
        self.description = description
        self.mediaCount = mediaCount
        
        let mediaInfo = json["medias"] as? [JSONDictionary] ?? []
        let medias = mediaInfo.flatMap { Wistia.Media(json: $0) }
        
        self.medias = medias
    }
}

extension Wistia.Project {
    
    internal static var list: Resource<[Wistia.Project]> {
        return try! Resource<[Wistia.Project]>(
            url: URL(route: .projects),
            parseElement: Wistia.Project.init
        )
    }
    
    internal func show(hashedId: String) -> Resource<Wistia.Project> {
        return try! Resource<Wistia.Project>(url: URL(route: .project(hashedId)), method: .get, parseJSON: { json -> Wistia.Project? in
            if let json = json as? JSONDictionary {
            return Wistia.Project(json: json)
            } else {
            return nil
            }
        })
    }
    
}

extension Wistia.Project {
    
}

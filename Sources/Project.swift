extension Wistia {
    public struct Project {
        
        let hashedId: String
        let name: String
        let description: String
        let medias: [Media]
        
    }
}

extension Wistia.Project {
    public init?(json: JSONDictionary) {
        guard let hashedId = json["hashedId"] as? String,
            let name = json["name"] as? String,
            let description = json["description"] as? String
            else { return nil }
        self.hashedId = hashedId
        self.name = name
        self.description = description
        
        let mediaInfo = json["medias"] as? [JSONDictionary] ?? []
        let medias = mediaInfo.flatMap { Wistia.Media(json: $0) }
        
        self.medias = medias
    }
}

public typealias ProjectListHandler = ([Wistia.Project]) -> ()
public typealias MediaListHandler = ([Wistia.Media]) -> ()
public typealias AccountHandler = (Wistia.Account) -> ()
public typealias ProjectHandler = (Wistia.Project) -> ()
public typealias MediaHandler = (Wistia.Media) -> ()
public typealias CaptionsListHandler = ([Wistia.CaptionFile]) -> ()

public struct Wistia {

    public var apiToken: String
    
    public init(apiToken: String) {
        self.apiToken = apiToken
    }
    
    internal func load<A>(resource: Resource<A>, complete: @escaping (A) -> ()) {
        
        Webservice(api_password: self.apiToken).load(resource) { result in
            switch result {
            case .error(let error):
                return print(error)
            case .success(let value):
                return complete(value)
            }
        }
        
    }
        
    public func listProjects(complete: @escaping ProjectListHandler) {
        load(resource: Project.list, complete: complete)
    }
    
    public func showProject(forHashedId hashedId: String, complete: @escaping ProjectHandler) {
        load(resource: Project.show(hashedId: hashedId), complete: complete)
    }
    
    public func showMedia(forHashedId hashedId: String, complete: @escaping MediaHandler) {
        load(resource: Media.show(hashedId: hashedId), complete: complete)
    }
    
    public func listMedias(forProject project: Project, complete: @escaping MediaListHandler) {
        load(resource: project.details) { project in
            complete(project.medias ?? [])
        }
    }
    
    public func listMedias(complete: @escaping MediaListHandler) {
        load(resource: Media.list, complete: complete)
    }
    
    public func listCaptions(forMedia media: Media, complete: @escaping CaptionsListHandler) {
        load(resource: media.captions, complete: complete)
    }
    
    public func showAccountDetails(complete: @escaping AccountHandler) {
        load(resource: Account.details, complete: complete)
    }
    

}

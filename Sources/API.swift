import Foundation

public protocol Path {
    var path: String { get }
}

public protocol APIRepresentable: Path {
    static var baseURL: URL { get }
}

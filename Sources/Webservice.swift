import Foundation

//
//  Webservice.swift
//  Videos
//
//  Created by Florian on 13/04/16.
//  Copyright © 2016 Chris Eidhof. All rights reserved.
//

public enum Result<A> {
    case success(A)
    case error(Error)
}

extension Result {
    public init(_ value: A?, or error: Error) {
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }
    
    public var value: A? {
        guard case .success(let v) = self else { return nil }
        return v
    }
}


public enum WebserviceError: Error {
    case notAuthenticated
    case other
}

func logError<A>(_ result: Result<A>) {
    guard case let .error(e) = result else { return }
    assert(false, "\(e)")
}

public final class Webservice {
    
    public var api_password: String
    public init(api_password: String) {
        self.api_password = api_password
    }
    
    /// Loads a resource. The completion handler is always called on the main queue.
    public func load<A>(_ resource: Resource<A>, completion: @escaping (Result<A>) -> () = logError) {
        
        let URLParams = [
            "api_password": api_password,
            ]
        let authenticatedUrl = resource.url.appendingQueryParameters(URLParams)
        
        URLSession.shared.dataTask(with: authenticatedUrl, completionHandler: { data, response, _ in
            let result: Result<A>
            if let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode == 401 {
                result = Result.error(WebserviceError.notAuthenticated)
            } else {
                let parsed = data.flatMap(resource.parse)
                result = Result(parsed, or: WebserviceError.other)
            }
            DispatchQueue.main.async { completion(result) }
        }) .resume()
    }
}

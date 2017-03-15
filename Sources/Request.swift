//
//  Request.swift
//  WistiaCore
//
//  Created by Jake Young on 3/15/17.
//
//

import Foundation

extension Wistia {
    
    public struct Request {
        
        //MARK: - Sorting
        /**
         Enumeration of the attributes by which you may sort (for API methods that support sorting).
         
         - `Name`: Sort by name of the objects.
         - `MediaCount`: Sort the MediaCount property of the objects.
         - `Created`: Sort by the created date of the objects.
         - `Updated`: Sort by the updated date of the objects.
         */
        public enum SortBy: String {
            /// Sort by name of the objects.
            case name = "name"
            
            /// Sort the MediaCount property of the objects.
            case mediaCount
            
            /// Sort by the created date of the objects.
            case created
            
            /// Sort by the updated date of the objects.
            case updated
        }
        
        /**
         Choice of direction when sorting.
         
         - `Descending`: Sort with the largest value or most-recent date first. Values decreasing as you move forward in the list.
         - `Ascending`: Sort the the smallest value or oldest date first.  Values increasing as you move forward in the list.
         */
        public enum SortDirection: Int {
            /// Sort with the largest value or most-recent date first. Values decreasing as you move forward in the list.
            case descending = 0
            
            /// Sort the the smallest value or oldest date first.  Values increasing as you move forward in the list.
            case ascending = 1
        }
        
        var route: Wistia.Route
        
        var apiToken: String? = nil
        
        var sortedBy: SortBy? = nil
        var sortDirection: SortDirection? = nil
        
        var parameters: [String: String] {
            guard let token = apiToken else { return [:] }
            var params = ["api_password": token]
            
            
            if let sortedBy = sortedBy {
                params["sort_by"] = sortedBy.rawValue
            }
            
            if let direction = sortDirection {
                params["sort_direction"] = "\(direction.rawValue)"
            }
            
            return params
        }
        
        mutating func addSorting(by sortBy: SortBy = .updated, withDirection direction: SortDirection = .descending) {
            self.sortedBy = sortBy
            self.sortDirection = direction
        }
        
        fileprivate var hasParameters: Bool { return !parameters.isEmpty }
        
        var url: URL {
            if hasParameters {
                return URL(route: self.route).appendingQueryParameters(self.parameters)
            } else {
                return URL(route: self.route)
            }
        }
        
        public init(route: Wistia.Route, apiToken: String?, sortedBy: Wistia.Request.SortBy? = nil, sortDirection: Wistia.Request.SortDirection? = nil) {
            self.route = route
            self.apiToken = apiToken
            self.sortedBy = sortedBy
            self.sortDirection = sortDirection
        }
        
    }
    
}

extension URL {
    init(route: Wistia.Route) {
        self = Wistia.Route.baseURL.appendingPathComponent(route.path)
    }
}

extension URLRequest {
    
    init(request: Wistia.Request) {
        self.init(url: request.url)
    }
    
}

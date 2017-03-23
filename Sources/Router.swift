//
//  Router.swift
//  WistiaCore
//
//  Created by Jake Young on 3/15/17.
//
//

import Foundation
extension Wistia {
    
    public enum Route: APIRepresentable {
        
        public static let baseURL = URL(string: "https://api.wistia.com/v1")!
        
        case project(String)
        case projects
        
        case media(String)
        case medias
        
        case captions(String)
        
        case account
        
        public var path: String {
            
            switch self {
                
                case .projects: return "/projects.json"
                case .medias: return "/medias.json"
                    
                case .project(let id): return "/projects/\(id).json"
                case .media(let id): return "/medias/\(id).json"
                case .captions(let id): return "/medias/\(id)/captions.json"
                    
                case .account: return "/account.json"
                
            }
            
        }
        
    }
    
    
    
}

//
//  TestExpectations.swift
//  WistiaCore
//
//  Created by Jake Young on 3/15/17.
//
//

import XCTest
@testable import WistiaCore

struct Expectations {
    
    struct URLs {
        static let account = "https://api.wistia.com/v1/account.json"
        static let projects = "https://api.wistia.com/v1/projects.json"
        static let medias = "https://api.wistia.com/v1/medias.json"
    }
    
    static func URLWithToken(url: String, token: String) -> String {
        return url + "?api_password=" + token
    }
    
}

//
//  RequestTests.swift
//  WistiaCore
//
//  Created by Jake Young on 3/15/17.
//
//
import XCTest
@testable import WistiaCore

import XCTest

class RequestTests: XCTestCase {
    
    var request: Wistia.Request!
    
    override func setUp() {
        super.setUp()
        request = Wistia.Request(route: .account, apiToken: nil)
    }
    
    func test_URLWithRoute_EmptyParams() {
        XCTAssertEqual(request.url.absoluteString, Expectations.URLs.account)
    }
    
    func test_URLWithRoute_Params_TokenOnly() {
        request.apiToken = "1234567890"
        XCTAssertEqual(request.url.absoluteString, Expectations.URLs.account + "?api_password=1234567890")
    }
    
    func test_URLWithRoute_Params_Token_Sorting() {
        request.apiToken = "1234567890"
        request.addSorting()
        XCTAssertEqual(request.url.absoluteString, Expectations.URLs.account + "?api_password=1234567890&sort_by=updated&sort_direction=0")
    }
    
    func test_Defaults() {
        request.apiToken = "1234567890"
        XCTAssertNil(request.sortDirection)
        XCTAssertNil(request.sortedBy)
        XCTAssertEqual(request.url.absoluteString, Expectations.URLs.account + "?api_password=1234567890")
    }
    
    func test_SortingAdded_Default() {
        request.apiToken = "1234567890"
        request.addSorting()
        XCTAssertEqual(request.sortedBy!, .updated)
        XCTAssertEqual(request.sortDirection!, .descending)
        XCTAssertEqual(request.url.absoluteString, Expectations.URLs.account + "?api_password=1234567890&sort_by=updated&sort_direction=0")
        
    }
    
    func test_SortingAdded_Created_Ascending() {
        request.apiToken = "1234567890"
        request.addSorting(by: .created, withDirection: .ascending)
        XCTAssertEqual(request.sortedBy!, .created)
        XCTAssertEqual(request.sortDirection!, .ascending)
        XCTAssertEqual(request.url.absoluteString, Expectations.URLs.account + "?api_password=1234567890&sort_by=created&sort_direction=1")
    }


}

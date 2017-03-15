//
//  JSON.swift
//  WistiaCore
//
//  Created by Jake Young on 3/15/17.
//
//

import Foundation

public typealias JSONDictionary = [String: Any]

public protocol JSONSerializable {
    init?(json: JSONDictionary)
}

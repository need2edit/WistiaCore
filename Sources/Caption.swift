//
//  Caption.swift
//  WistiaCore
//
//  Created by Jake Young on 3/21/17.
//
//

import Foundation

extension Wistia {
    
    public struct CaptionFile {
        public let englishName: String
        public let nativeName: String
        public let language: String
        public let text: String
    }

}

extension Wistia.CaptionFile: JSONSerializable {
    public init?(json dictionary: JSONDictionary) {
        guard let englishName = dictionary["english_name"] as? String, let nativeName = dictionary["native_name"] as? String, let language = dictionary["language"] as? String, let text = dictionary["text"] as? String else { return nil }
        self.init(englishName: englishName, nativeName: nativeName, language: language, text: text)
    }
}

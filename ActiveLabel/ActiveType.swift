//
//  ActiveType.swift
//  ActiveLabel
//
//  Created by Johannes Schickling on 9/4/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

enum ActiveElement {
    case mention(String)
    case hashtag(String)
    case url(original: String, trimmed: String)
    case lookMore(original: String, trimmed: String)
    case custom(String)
    
    static func create(with activeType: ActiveType, text: String) -> ActiveElement {
        switch activeType {
        case .mention: return mention(text)
        case .hashtag: return hashtag(text)
        case .url: return url(original: text, trimmed: text)
        case .lookMore: return lookMore(original: text, trimmed: text)
        case .custom: return custom(text)
        }
    }
}

public enum ActiveType {
    case mention
    case hashtag
    case url
    case lookMore
    case custom(pattern: String)
    
    var pattern: String {
        switch self {
        case .mention: return RegexParser.mentionPattern
        case .hashtag: return RegexParser.hashtagPattern
        case .url: return RegexParser.urlPattern
        case .lookMore: return "阅读全文    "
        case .custom(let regex): return regex
        }
    }
}

extension ActiveType: Hashable, Equatable {
    public var hashValue: Int {
        switch self {
        case .mention: return -1
        case .hashtag: return -2
        case .url: return -3
        case .lookMore: return -4
        case .custom(let regex): return regex.hashValue
        }
    }
}

public func ==(lhs: ActiveType, rhs: ActiveType) -> Bool {
    switch (lhs, rhs) {
    case (.mention, .mention): return true
    case (.hashtag, .hashtag): return true
    case (.url, .url): return true
    case (.lookMore, .lookMore): return true
    case (.custom(let pattern1), .custom(let pattern2)): return pattern1 == pattern2
    default: return false
    }
}

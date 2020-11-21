//
//  DeepLink.swift
//  DeepLinking
//
//  Created by Egor Iskrenkov on 21.11.20.
//

import Foundation

/// Adopted by a type whose values are matched and extracted from a URL
public protocol DeepLink {

    /// Returns a template that describes how to match and extract values from a URL
    static var template: DeepLinkTemplate { get }

    /// Initializes a new instance with values extracted from a URL
    /// - Parameter values: Data values from a URL, whose keys are the names specified in a `DeepLinkTemplate`
    init(values: DeepLinkValues)

}

/// Data values extracted from a URL by a deep link template
public struct DeepLinkValues {

    /// Values in the URL's path, whose keys are the names specified in a deep link template
    public let path: [String: Any]

    /// Values in the URL's query string, whose keys are the names specified in a deep link template
    public let query: [String: Any]

    /// The URL's fragment (i.e. text following a # symbol), if available
    public let fragment: String?

    init(path: [String: Any], query: [String: Any], fragment: String?) {
        self.path = path
        self.query = query
        self.fragment = fragment
    }

}

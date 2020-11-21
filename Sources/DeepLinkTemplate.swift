//
//  DeepLinkTemplate.swift
//  DeepLinking
//
//  Created by Egor Iskrenkov on 21.11.20.
//

import Foundation

/// Describes how to extract a deep link's values from a URL
/// A template is considered to match a URL if all of its required values are found in the URL
public struct DeepLinkTemplate {

    // MARK: - State
    internal enum PathPart {
        case int(name: String)
        case bool(name: String)
        case string(name: String)
        case double(name: String)
        case term(symbol: String)
    }

    internal let pathParts: [PathPart]
    internal let parameters: Set<QueryStringParameter>

    // MARK: - Public API
    public init() {
        self.init(pathParts: [], parameters: [])
    }

    /// A matching URL must include this constant string at the correct location in its path
    public func term(_ symbol: String) -> DeepLinkTemplate {
        return appending(pathPart: .term(symbol: symbol))
    }

    /// A matching URL must include a string at the correct location in its path
    /// - Parameter name: The key of this string in the `path` dictionary of `DeepLinkValues`
    public func string(named name: String) -> DeepLinkTemplate {
        return appending(pathPart: .string(name: name))
    }

    /// A matching URL must include an integer at the correct location in its path
    /// - Parameter name: The key of this integer in the `path` dictionary of `DeepLinkValues`
    public func int(named name: String) -> DeepLinkTemplate {
        return appending(pathPart: .int(name: name))
    }

    /// A matching URL must include a double at the correct location in its path
    /// - Parameter name: The key of this double in the `path` dictionary of `DeepLinkValues`
    public func double(named name: String) -> DeepLinkTemplate {
        return appending(pathPart: .double(name: name))
    }

    /// A matching URL must include a boolean at the correct location in its path
    /// - Parameter name: The key of this boolean in the `path` dictionary of `DeepLinkValues`
    public func bool(named name: String) -> DeepLinkTemplate {
        return appending(pathPart: .bool(name: name))
    }

    /// An unordered set of query string parameters
    /// - Parameter queryStringParameters: A set of parameters that may be required or optional
    public func queryStringParameters(_ queryStringParameters: Set<QueryStringParameter>) -> DeepLinkTemplate {
        return DeepLinkTemplate(pathParts: pathParts, parameters: queryStringParameters)
    }

    /// A named value in a URL's query string
    public enum QueryStringParameter {
        case requiredInt(named: String), optionalInt(named: String)
        case requiredBool(named: String), optionalBool(named: String)
        case requiredDouble(named: String), optionalDouble(named: String)
        case requiredString(named: String), optionalString(named: String)
    }

    // MARK: - Private creation methods
    private init(pathParts: [PathPart], parameters: Set<QueryStringParameter>) {
        self.pathParts = pathParts
        self.parameters = parameters
    }

    private func appending(pathPart: PathPart) -> DeepLinkTemplate {
        return DeepLinkTemplate(pathParts: pathParts + [pathPart], parameters: parameters)
    }

}

// MARK: - QueryStringParameter extension
extension DeepLinkTemplate.QueryStringParameter: Hashable, Equatable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }

    public static func == (lhs: DeepLinkTemplate.QueryStringParameter,
                           rhs: DeepLinkTemplate.QueryStringParameter) -> Bool {
        return lhs.name == rhs.name
    }

    internal var name: String {
        switch self {
        case let .requiredInt(name): return name
        case let .requiredBool(name): return name
        case let .requiredDouble(name): return name
        case let .requiredString(name): return name
        case let .optionalInt(name): return name
        case let .optionalBool(name): return name
        case let .optionalDouble(name): return name
        case let .optionalString(name): return name
        }
    }

    internal enum ParameterType { case string, int, double, bool }

    internal var type: ParameterType {
        switch self {
        case .requiredInt, .optionalInt: return .int
        case .requiredBool, .optionalBool: return .bool
        case .requiredDouble, .optionalDouble: return .double
        case .requiredString, .optionalString: return .string
        }
    }

    internal var isRequired: Bool {
        switch self {
        case .requiredInt, .requiredBool, .requiredDouble, .requiredString: return true
        case .optionalInt, .optionalBool, .optionalDouble, .optionalString: return false
        }
    }

}

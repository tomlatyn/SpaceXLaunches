//
//  BasicError.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public typealias StatusCode = Int

public enum ConnectionError: Error {
    case timeout(_ message: String = "")
}

public enum GeneralError: Error {
    case unknown(_ message: String = "")
}

public enum MappingError: Error {
    case decoding(_ message: String)
    case encoding(_ message: String)
}

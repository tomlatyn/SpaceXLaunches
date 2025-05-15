//
//  LaunchModel.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation

public struct LaunchModel: Identifiable {
    public let id: String
    public let success: Bool?
    public let details: String?
    public let flightNumber: Int?
    public let name: String
    public let dateUnix: Int?
    public let dateLocal: Date?
    public let articleLink: String?
}

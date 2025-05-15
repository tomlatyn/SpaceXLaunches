//
//  LaunchDTO.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation

struct LaunchDTO: Codable {
    let id: String
    let success: Bool?
    let details: String?
    let crew: [Crew]
    let launchpad: String
    let flightNumber: Int?
    let name: String
    let dateUnix: Int?
    let dateLocal: String?

    // MARK: - Crew
    
    struct Crew: Codable {
        let crew, role: String
    }
}

// MARK: - Mapping

extension LaunchDTO {
    func mapToModel() -> LaunchModel {
        let dateFormatter = ISO8601DateFormatter()
        
        return LaunchModel(
            id: id,
            success: success,
            details: details,
            launchpad: launchpad,
            flightNumber: flightNumber,
            name: name,
            dateUnix: dateUnix,
            dateLocal: dateLocal == nil ? nil : dateFormatter.date(from: dateLocal!)
        )
    }
}

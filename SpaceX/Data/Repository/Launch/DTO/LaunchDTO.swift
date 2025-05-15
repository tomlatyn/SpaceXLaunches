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
    let flightNumber: Int?
    let name: String
    let dateUnix: Int?
    let dateLocal: String?
    let links: Links?

    // MARK: - Links
    
    struct Links: Codable {
        let article: String?
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
            flightNumber: flightNumber,
            name: name,
            dateUnix: dateUnix,
            dateLocal: dateLocal == nil ? nil : dateFormatter.date(from: dateLocal!),
            articleLink: links?.article
        )
    }
}

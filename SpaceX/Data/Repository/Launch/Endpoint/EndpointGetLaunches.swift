//
//  EndpointGetLaunches.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import FTAPIKit

struct EndpointGetLaunches: ResponseEndpoint {
    typealias Response = [LaunchDTO]

    var method = HTTPMethod.get
    var path: String = "v5/launches/"

    init() {
        
    }
    
}

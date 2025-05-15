//
//  LaunchRepository.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation

public protocol LaunchRepository: AnyObject {
    func getLaunches() async throws -> [LaunchModel]
}

// MARK: - Implementation

public final class LaunchRepositoryImpl: LaunchRepository {
    
    // MARK: - Instance properties
    
    private let restClient: RESTClient
    private let server: BaseServer
    
    // MARK: - Lifecycle
    
    init(
        restClient: RESTClient,
        server: BaseServer
    ) {
        self.restClient = restClient
        self.server = server
    }
    
    // MARK: - Implementation
    
    public func getLaunches() async throws -> [LaunchModel] {
        try await restClient.call { [server] in
            try await server.call(response: EndpointGetLaunches())
                .map { $0.mapToModel() }
        }
    }
    
}

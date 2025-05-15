//
//  LaunchListFeature.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import SwiftUI
import Swinject
import SwinjectAutoregistration

final class LaunchListFeature: Assembly {
    func assemble(container: Container) {
        container.autoregister(LaunchListCoordinator.self, initializer: LaunchListCoordinatorImpl.init)
        container.autoregister(LaunchListViewModel.self, initializer: LaunchListViewModel.init)
        container.register(LaunchListFactory.self, factory: LaunchListFactoryImpl.init)
    }
}

final class LaunchListFactoryImpl: LaunchListFactory {
    // MARK: - Properties
    
    private let resolver: Resolver
    
    // MARK: - Lifecycle
    
    nonisolated init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    // MARK: - Resolving
    
    var coordinator: LaunchListCoordinator {
        resolver.resolve(LaunchListCoordinator.self)!
    }
    
    func resolveView() -> AnyView {
        AnyView(
            LaunchListView(
                viewModel: resolver.resolve(LaunchListViewModel.self)!,
                coordinator: coordinator
            )
        )
    }
}

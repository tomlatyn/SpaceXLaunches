//
//  LaunchDetailFeature.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import SwiftUI
import Swinject
import SwinjectAutoregistration

final class LaunchDetailFeature: Assembly {
    func assemble(container: Container) {
        container.autoregister(LaunchDetailCoordinator.self, initializer: LaunchDetailCoordinatorImpl.init)
        container.autoregister(LaunchDetailViewModel.self, argument: LaunchModel.self, initializer: LaunchDetailViewModel.init)
        container.register(LaunchDetailFactory.self, factory: LaunchDetailFactoryImpl.init)
    }
}

final class LaunchDetailFactoryImpl: LaunchDetailFactory {
    // MARK: - Properties
    
    private let resolver: Resolver
    
    // MARK: - Lifecycle
    
    nonisolated init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    // MARK: - Resolving
    
    var coordinator: LaunchDetailCoordinator {
        resolver.resolve(LaunchDetailCoordinator.self)!
    }
    
    func resolveView(_ launch: LaunchModel) -> AnyView {
        AnyView(
            LaunchDetailView(
                viewModel: resolver.resolve(LaunchDetailViewModel.self, argument: launch)!,
                coordinator: coordinator
            )
        )
    }
}

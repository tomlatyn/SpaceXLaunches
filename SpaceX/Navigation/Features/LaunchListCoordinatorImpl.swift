//
//  LaunchListCoordinatorImpl.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import SwiftUI

final class LaunchListCoordinatorImpl: LaunchListCoordinator {
    
    // MARK: - Properties
    
    private let appCoordinator: AppCoordinator
    private let factory: LaunchListFactory
    private let launchDetailFactory: LaunchDetailFactory
    
    // MARK: - Lifecycle
    
    nonisolated init(
        appCoordinator: AppCoordinator,
        factory: LaunchListFactory,
        launchDetailFactory: LaunchDetailFactory
    ) {
        self.appCoordinator = appCoordinator
        self.factory = factory
        self.launchDetailFactory = launchDetailFactory
    }
    
    // MARK: - Navigation
    
    func start() {
        let vc = factory.resolveViewController()
        appCoordinator.navigationController.pushViewController(vc, animated: false)
    }
    
    func navigate(_ path: LaunchListPath) {
        switch path {
        case .detail(let launchModel):
            launchDetailFactory.coordinator.start(launchModel)
        }
    }
}

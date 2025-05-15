//
//  LaunchDetailCoordinatorImpl.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import SwiftUI

final class LaunchDetailCoordinatorImpl: LaunchDetailCoordinator {
    
    // MARK: - Properties
    
    private let appCoordinator: AppCoordinator
    private let factory: LaunchDetailFactory
    
    // MARK: - Lifecycle
    
    nonisolated init(
        appCoordinator: AppCoordinator,
        factory: LaunchDetailFactory
    ) {
        self.appCoordinator = appCoordinator
        self.factory = factory
    }
    
    // MARK: - Navigation
    
    func start(_ launch: LaunchModel) {
        let vc = UIHostingController(rootView: factory.resolveView(launch))
        appCoordinator.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigate(_ path: LaunchDetailPath) {
        switch path {
        
        }
    }
}

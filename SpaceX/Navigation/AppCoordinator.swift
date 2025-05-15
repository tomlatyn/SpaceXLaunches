//
//  AppCoordinator.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import SwiftUI
import UIKit

protocol AppCoordinator: Coordinator {
    
}

// MARK: - Class

final class AppCoordinatorImpl: CoordinatorImpl, AppCoordinator {
    
    // MARK: - Properties
    
    private let launchListFactory: LaunchListFactory
    
    // MARK: - Lifecycle
    
    init(
        navigationController: UINavigationController,
        launchListFactory: LaunchListFactory
    ) {
        self.launchListFactory = launchListFactory
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Implementation
    
    override func start() {
        launchListFactory.coordinator.start()
    }
    
}

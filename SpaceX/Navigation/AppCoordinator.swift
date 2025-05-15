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
    
    // MARK: - Lifecycle
    
    override init(
        navigationController: UINavigationController
    ) {
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Implementation
    
    override func start() {
        navigationController.viewControllers = [UIHostingController(rootView: AnyView(Text("Hello")))]
    }
    
}

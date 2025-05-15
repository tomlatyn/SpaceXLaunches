//
//  LaunchDetailCoordinator.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation

public enum LaunchDetailPath {
    
}

public protocol LaunchDetailCoordinator: AnyObject {
    @MainActor func start(_ launch: LaunchModel)
    @MainActor func navigate(_ path: LaunchDetailPath)
}

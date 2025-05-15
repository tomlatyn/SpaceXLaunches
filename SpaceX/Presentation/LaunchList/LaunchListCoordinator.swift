//
//  LaunchListCoordinator.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation

public enum LaunchListPath {
    case detail(LaunchModel)
}

public protocol LaunchListCoordinator: AnyObject {
    @MainActor func start()
    @MainActor func navigate(_ path: LaunchListPath)
}

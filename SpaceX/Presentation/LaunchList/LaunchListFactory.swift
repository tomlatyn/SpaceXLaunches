//
//  LaunchListFactory.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import SwiftUI

public protocol LaunchListFactory: AnyObject {
    @MainActor var coordinator: LaunchListCoordinator { get }
    @MainActor func resolveView() -> AnyView
}

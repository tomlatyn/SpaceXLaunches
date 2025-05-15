//
//  LaunchDetailFactory.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import SwiftUI

public protocol LaunchDetailFactory: AnyObject {
    @MainActor var coordinator: LaunchDetailCoordinator { get }
    @MainActor func resolveView(_ launch: LaunchModel) -> AnyView
}

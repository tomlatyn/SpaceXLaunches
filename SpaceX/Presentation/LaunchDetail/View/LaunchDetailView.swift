//
//  LaunchDetailView.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import SwiftUI

public struct LaunchDetailView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: LaunchDetailViewModel
    private let coordinator: LaunchDetailCoordinator
    
    // MARK: - Lifecycle
    
    public init(
        viewModel: LaunchDetailViewModel,
        coordinator: LaunchDetailCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    // MARK: - Layout
    
    public var body: some View {
        ZStack {
            layoutMain
        }
    }
    
    @ViewBuilder
    private var layoutMain: some View {
        Text(viewModel.launch.name)
    }
}

//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import SwiftUI

public struct LaunchListView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: LaunchListViewModel
    private let coordinator: LaunchListCoordinator
    
    // MARK: - Lifecycle
    
    public init(
        viewModel: LaunchListViewModel,
        coordinator: LaunchListCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    // MARK: - Layout
    
    public var body: some View {
        ZStack {
            layoutMain
        }
        .task {
            await viewModel.loadData()
        }
    }
    
    @ViewBuilder
    private var layoutMain: some View {
        if viewModel.launches.isEmpty {
            Text("loading")
        } else {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.launches) { launch in
                        Text(launch.name)
                            .onTapGesture {
                                coordinator.navigate(.detail(launch))
                            }
                    }
                }
            }
        }
    }
}

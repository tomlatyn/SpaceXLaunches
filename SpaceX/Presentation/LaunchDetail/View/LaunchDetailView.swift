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
        launchInfoLayout(viewModel.launch)
    }
    
    private func launchInfoLayout(_ launch: LaunchModel) -> some View {
        List {
            Section(R.string.localizable.launch_detail_info()) {
                listRow(title: R.string.localizable.launch_detail_name(), text: launch.name)
                
                if let flightNumber = launch.flightNumber {
                    listRow(title: R.string.localizable.launch_detail_flight_number(), text: flightNumber.description)
                }
                
                if let date = launch.dateLocal?.formatted(date: .complete, time: .shortened) {
                    listRow(title: R.string.localizable.launch_detail_local_date(), text: date)
                }
                
                if let success = launch.success {
                    listRow(
                        title: R.string.localizable.launch_detail_successful(),
                        text: success ? R.string.localizable.yes() : R.string.localizable.no()
                    )
                }
                
                if let details = launch.details {
                    listRow(title: R.string.localizable.launch_detail_details(), text: details)
                }
                
                if let articleLink = launch.articleLink, let url = URL(string: articleLink) {
                    listRow(title: R.string.localizable.launch_detail_article(), text: articleLink, destination: url)
                }
            }
        }
    }
    
    private func listRow(title: String, text: String, destination: URL? = nil) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            if let destination = destination {
                Link(text, destination: destination)
            } else {
                Text(text)
            }
        }
    }
}

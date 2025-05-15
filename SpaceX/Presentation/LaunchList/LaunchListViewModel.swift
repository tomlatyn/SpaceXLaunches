//
//  LaunchListViewModel.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation

public final class LaunchListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let launchRepository: LaunchRepository
    
    // MARK: - Published properties
    
    @Published var viewState = BaseViewState.loading
    @Published var launches: [LaunchModel] = []
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        launchRepository: LaunchRepository
    ) {
        self.launchRepository = launchRepository
    }
    
    // MARK: -
    
    @MainActor
    func loadData() async {
        viewState = await .newViewState {
            self.launches = try await launchRepository.getLaunches()
        }
    }
    
}

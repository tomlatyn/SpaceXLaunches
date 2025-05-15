//
//  LaunchListViewModel.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import Combine

class LaunchListViewModel {
    
    // MARK: - Properties
    
    private let launchRepository: LaunchRepository
    private let preferencesRepository: PreferencesRepository
    
    var viewState: BaseViewState = .loading {
        didSet {
            onStateChanged?(viewState)
        }
    }
    
    var launches: [LaunchModel] = [] {
        didSet {
            if searchQuery.isEmpty {
                filteredLaunches = launches
            } else {
                performSearch(query: searchQuery)
            }
            onDataChanged?()
        }
    }
    
    var filteredLaunches: [LaunchModel] = [] {
        didSet {
            onDataChanged?()
        }
    }
    
    var searchQuery: String = "" {
        didSet {
            performSearch(query: searchQuery)
        }
    }
    
    var onDataChanged: (() -> Void)?
    var onStateChanged: ((BaseViewState) -> Void)?
    
    // MARK: - Lifecycle
    
    init(
        launchRepository: LaunchRepository,
        preferencesRepository: PreferencesRepository
    ) {
        self.launchRepository = launchRepository
        self.preferencesRepository = preferencesRepository
    }
    
    // MARK: - Data Methods
    
    func loadData() async {
        viewState = .loading
        onStateChanged?(viewState)
        
        viewState = await .newViewState {
            self.launches = try await launchRepository.getLaunches()
            switch preferencesRepository.launchSortType {
            case .dateAscending:
                sortByLaunchDateAscending()
            case .dateDescending:
                sortByLaunchDateDescending()
            case .nameAscending:
                sortByNameAscending()
            case .nameDescending:
                sortByNameDescending()
            }
        }
    }
    
    // MARK: - Sort Methods
    
    func sortByNameAscending() {
        launches.sort { $0.name.lowercased() < $1.name.lowercased() }
        preferencesRepository.launchSortType = .nameAscending
    }
    
    func sortByNameDescending() {
        launches.sort { $0.name.lowercased() > $1.name.lowercased() }
        preferencesRepository.launchSortType = .nameDescending
    }
    
    func sortByLaunchDateAscending() {
        launches.sort {
            guard let firstDate = $0.dateLocal else { return false }
            guard let secondDate = $1.dateLocal else { return true }
            return firstDate < secondDate
        }
        preferencesRepository.launchSortType = .dateAscending
    }
    
    func sortByLaunchDateDescending() {
        launches.sort {
            guard let firstDate = $0.dateLocal else { return false }
            guard let secondDate = $1.dateLocal else { return true }
            return firstDate > secondDate
        }
        preferencesRepository.launchSortType = .dateDescending
    }
    
    // MARK: - Search Methods
    
    func search(query: String) {
        searchQuery = query
    }
    
    private func performSearch(query: String) {
        if query.isEmpty {
            filteredLaunches = launches
        } else {
            filteredLaunches = launches.filter {
                $0.name.localizedCaseInsensitiveContains(query)
            }
        }
    }
}

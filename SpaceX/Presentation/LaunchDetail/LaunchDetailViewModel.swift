//
//  LaunchDetailViewModel.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation

public final class LaunchDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let launch: LaunchModel
    
    // MARK: - Lifecycle
    
    public nonisolated init(
        launch: LaunchModel
    ) {
        self.launch = launch
    }
    
}

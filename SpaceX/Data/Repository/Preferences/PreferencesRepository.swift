//
//  PreferencesRepository.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation

public protocol PreferencesRepository: AnyObject {
    var launchSortType: LaunchSortType { get set }
}

// MARK: - Class

public class PreferencesRepositoryImpl: PreferencesRepository {
    
    // MARK: - Properties
    
    let userDefaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    
    public init() {
        
    }
    
    // MARK: - Public properties
    
    public var launchSortType: LaunchSortType {
        get {
            LaunchSortType(rawValue: userDefaults.string(forKey: "launchSortType") ?? "") ?? .dateDescending
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: "launchSortType")
        }
    }
}

// MARK: - Sort Type

public enum LaunchSortType: String {
    case nameAscending
    case nameDescending
    case dateAscending
    case dateDescending
}

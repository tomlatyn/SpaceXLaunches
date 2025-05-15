//
//  LaunchListViewController+TableViewDelegate.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import UIKit

extension LaunchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath)
        let launch = viewModel.filteredLaunches[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = launch.name
        content.secondaryText = launch.dateLocal?.formatted(date: .numeric, time: .shortened) ?? "No launch date"
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedLaunch = viewModel.filteredLaunches[indexPath.row]
        coordinator.navigate(.detail(selectedLaunch))
    }
}

//
//  LaunchListViewController.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import UIKit

class LaunchListViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: LaunchListViewModel
    let coordinator: LaunchListCoordinator
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private let errorView = ErrorView()
    
    // MARK: - Initialization
    
    init(viewModel: LaunchListViewModel, coordinator: LaunchListCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBindings()
        setupSearchController()
        setupNavigationBar()
        
        Task {
            await viewModel.loadData()
        }
    }
    
    // MARK: - Setup
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LaunchCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupBindings() {
        viewModel.onDataChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.onStateChange(state: state)
            }
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = R.string.localizable.launch_list_search_placeholder()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func setupNavigationBar() {
        let sortButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(showSortOptions)
        )
        navigationItem.rightBarButtonItem = sortButton
    }
    
    private func onStateChange(state: BaseViewState) {
        switch state {
        case .loading:
            tableView.isHidden = true
            errorView.isHidden = true
            activityIndicator.startAnimating()
            searchController.searchBar.isUserInteractionEnabled = false
            navigationItem.rightBarButtonItem?.isEnabled = false
        case .ok:
            tableView.isHidden = false
            errorView.isHidden = true
            activityIndicator.stopAnimating()
            searchController.searchBar.isUserInteractionEnabled = true
            navigationItem.rightBarButtonItem?.isEnabled = true
        case .generalError, .connectionError:
            tableView.isHidden = true
            errorView.isHidden = false
            activityIndicator.stopAnimating()
            errorView.configure(
                type: state == .connectionError ? .connection : .general(nil),
                retryAction: retryButtonTapped
            )
            searchController.searchBar.isUserInteractionEnabled = false
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    // MARK: - Actions
    
    @objc private func retryButtonTapped() {
        Task {
            await viewModel.loadData()
        }
    }
    
    @objc private func showSortOptions() {
        let alertController = UIAlertController(
            title: R.string.localizable.launch_sort_title(),
            message: nil,
            preferredStyle: .actionSheet
        )
        
        alertController.addAction(UIAlertAction(title: R.string.localizable.launch_sort_name_ascending(), style: .default) { [weak self] _ in
            self?.viewModel.sortByNameAscending()
        })
        
        alertController.addAction(UIAlertAction(title: R.string.localizable.launch_sort_name_descending(), style: .default) { [weak self] _ in
            self?.viewModel.sortByNameDescending()
        })
        
        alertController.addAction(UIAlertAction(title: R.string.localizable.launch_sort_date_ascending(), style: .default) { [weak self] _ in
            self?.viewModel.sortByLaunchDateAscending()
        })
        
        alertController.addAction(UIAlertAction(title: R.string.localizable.launch_sort_date_descending(), style: .default) { [weak self] _ in
            self?.viewModel.sortByLaunchDateDescending()
        })
        
        alertController.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .cancel))
        
        present(alertController, animated: true)
    }
}

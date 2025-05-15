//
//  ErrorView.swift
//  SpaceX
//
//  Created by Tomáš Latýn on 15.05.2025.
//

import Foundation
import UIKit

class ErrorView: UIView {
    
    // MARK: - Properties
    
    private let errorLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    
    var retryAction: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.font = .systemFont(ofSize: 16)
        
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.setTitle(R.string.localizable.try_again(), for: .normal)
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        
        addSubview(errorLabel)
        addSubview(retryButton)
        retryButton.isHidden = retryAction == nil
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    func configure(type: ErrorType, retryAction: (() -> Void)?) {
        switch type {
        case .general(let message):
            errorLabel.text = message ?? R.string.localizable.error_general_text()
        case .connection:
            errorLabel.text = R.string.localizable.error_connection_text()
        }
        
        self.retryAction = retryAction
        retryButton.isHidden = retryAction == nil
    }
    
    // MARK: - Actions
    
    @objc private func retryButtonTapped() {
        retryAction?()
    }
}

// MARK: - ErrorType

extension ErrorView {
    enum ErrorType {
        case general(_ customMessage: String?)
        case connection
    }
}

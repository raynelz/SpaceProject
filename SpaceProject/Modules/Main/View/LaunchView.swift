//
//  LaunchView.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 19.08.2024.
//

import UIKit
import SnapKit

final class LaunchView: UIView {
    // MARK: - UI Components
    
    /// Таблица для отображения списка запусков
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAppearance()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension LaunchView {
    // MARK: - Setup Views
    
    func setupViews() {
        addSubview(tableView)
    }
    
    // MARK: - Setup Appearance
    
    func setupAppearance() {
        backgroundColor = SpaceAppColor.background
        tableView.backgroundColor = SpaceAppColor.background
    }
    
    // MARK: - Setup Layout
    
    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

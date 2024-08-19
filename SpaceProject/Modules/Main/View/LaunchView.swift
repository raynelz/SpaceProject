//
//  LaunchView.swift
//  SpaceProject
//
//  Created by Захар Литвинчук on 19.08.2024.
//

import UIKit
import SnapKit

final class LaunchView: UIView {
    // MARK: - UI Components

    let tableView = UITableView()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        embedViews()
        setupAppearance()
        setupLayout()
        setupBehavior()
        setupData()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension LaunchView {
    // MARK: - Embed Views

    func embedViews() {
        addSubview(tableView)
    }

    // MARK: - Setup Appearance

    func setupAppearance() {
        backgroundColor = .white

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LaunchCell")
        tableView.backgroundColor = .clear
    }

    // MARK: - Setup Layout

    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Setup Behavior

    func setupBehavior() {
    }

    // MARK: - Setup Data

    func setupData() {
    }
}

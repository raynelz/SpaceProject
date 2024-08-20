//
//  LaunchViewCell.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 20.08.2024.
//

import UIKit
import SnapKit

final class LaunchViewCell: UITableViewCell {
    // MARK: - UI Components
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = SpaceAppColor.cellText.darkVariant
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = SpaceAppColor.text.darkVariant
        return label
    }()
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupLayout()
        setupCellAppearance()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Configuration
    func configure(with name: String, date: String, isSuccess: Bool) {
        nameLabel.text = name
        dateLabel.text = date
        iconImageView.image = isSuccess ? UIImage(systemName: "checkmark.circle.fill") :
        UIImage(systemName: "xmark.circle.fill")
        iconImageView.tintColor = isSuccess ? .systemGreen : .systemRed
    }
}

// MARK: - Private Methods

private extension LaunchViewCell {
    // MARK: - Embed Views
    func embedViews() {
        contentView.addSubviews(nameLabel, dateLabel, iconImageView)
    }
    // MARK: - Setup Appearance
    func setupCellAppearance() {
        contentView.backgroundColor = SpaceAppColor.cellBackground.darkVariant
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    // MARK: - Setup Layout
    func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(16)
        }
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
}

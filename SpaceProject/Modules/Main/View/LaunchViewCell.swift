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
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = SpaceAppColor.text
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = SpaceAppColor.cellText
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
        setupViews()
        setupLayout()
        setupCellAppearance()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(model: LaunchesResponse) {
        nameLabel.text = model.name
        dateLabel.text = convertData(dateUtc: model.dateUnix)
        iconImageView.image = model.success ?? false ? UIImage(named: "rocket-done") :
        UIImage(named: "rocket-fail")
    }
}

// MARK: - Private Methods

private extension LaunchViewCell {
    
    // MARK: - Setup Views
    func setupViews() {
        contentView.addSubviews(nameLabel, dateLabel, iconImageView)
    }
    
    // MARK: - Setup Appearance
    func setupCellAppearance() {
        backgroundColor = .clear
        contentView.backgroundColor = SpaceAppColor.cellBackground
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        // Selected Cell
        let selectedBackgroundColor = UIView()
        selectedBackgroundColor.backgroundColor = SpaceAppColor.cellBackground
        self.selectedBackgroundView = selectedBackgroundColor
        self.selectedBackgroundView?.layer.cornerRadius = 20
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(25)
            make.trailing.equalTo(iconImageView.snp.leading).offset(-20)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.bottom.equalToSuperview().inset(25)
        }
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    // MARK: - Converting Date UTC
    func convertData(dateUtc: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let date = Date(timeIntervalSince1970: dateUtc)
        dateFormatter.locale = Locale(identifier: "ru_US")
        return dateFormatter.string(from: date)
    }
}

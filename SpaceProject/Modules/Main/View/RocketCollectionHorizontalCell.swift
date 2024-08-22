//
//  RocketCollectionHorizontalCell.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 17.08.2024.
//

import UIKit
import SnapKit

final class RocketCollectionHorizontalCell: UICollectionViewCell {
    static let identifier = "RocketCollectionHorizontalCell"
    
    // MARK: - UI Components
    private let mainLabel = UILabel()
    private let secondaryLabel = UILabel()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension RocketCollectionHorizontalCell {
    // MARK: - Embed Views
    
    func embedViews() {
        addSubviews(
            mainLabel,
            secondaryLabel
        )
    }
    
    // MARK: - Setup Appearance
    
    func setupAppearance() {
        layer.cornerRadius = 40
        backgroundColor = SpaceAppColor.cellBackground
        
        mainLabel.text = "MainLabel"
        mainLabel.textColor = SpaceAppColor.text
        mainLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        secondaryLabel.text = "SecondaryLabel"
        secondaryLabel.textColor = SpaceAppColor.cellText
        secondaryLabel.font = .systemFont(ofSize: 15)
        
        [mainLabel, secondaryLabel].forEach {
            $0.textAlignment = .center
        }
    }
    
    // MARK: - Setup Layout
    
    func setupLayout() {
        mainLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
        }
        
        secondaryLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.centerY.equalToSuperview().offset(10)
        }
    }
}

extension RocketCollectionHorizontalCell {
    // MARK: - Setup data
    
    func setupData(_ data: RocketCollectionModel.CellData) {
        mainLabel.text = data.mainText
        
        if let units = data.unitsOfMeasurement {
            secondaryLabel.text = "\(data.secondaryText), \(units)"
        } else {
            secondaryLabel.text = data.secondaryText
        }
    }
}

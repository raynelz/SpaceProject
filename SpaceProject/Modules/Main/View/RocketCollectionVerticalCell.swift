//
//  RocketCollectionVerticalCell.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 17.08.2024.
//

import UIKit
import SnapKit

final class RocketCollectionVerticalCell: UICollectionViewCell {
    static let identifier = "RocketCollectionVerticalCell"
    
    /// cellType:
    ///     0 - Standart horizontal cell
    ///     1 - Horizontal cell with units of measurement
    var cellType = 0 {
        didSet {
            updateUnitsVisability()
        }
    }
    
    var standartRightLabelConstraint: Constraint?
    var rightWithUnitsConstraint: Constraint?
    
    // MARK: - UI Components
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    let unitsLabel = UILabel()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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

private extension RocketCollectionVerticalCell {
    // MARK: - Embed Views
    
    func embedViews() {
        addSubviews(
            leftLabel,
            rightLabel,
            unitsLabel
        )
    }
    
    // MARK: - Setup Appearance
    
    func setupAppearance() {
        leftLabel.text = "LeftLabel"
        leftLabel.textColor = SpaceAppColor.cellText.darkVariant
        leftLabel.textAlignment = .left
        
        rightLabel.text = "RightLabel"
        rightLabel.textColor = SpaceAppColor.text.darkVariant
        rightLabel.textAlignment = .right
        
        unitsLabel.text = "UM"
        unitsLabel.textColor = SpaceAppColor.cellText.darkVariant
        unitsLabel.textAlignment = .left
        unitsLabel.isHidden = true
        
        [leftLabel, rightLabel, unitsLabel].forEach {
            $0.font = .systemFont(ofSize: 15)
        }
    }
    
    // MARK: - Setup Layout
    
    func setupLayout() {
        leftLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.right.equalTo(rightLabel.snp.left)
        }
        
        // FIXME: Constrains conflict?...
        rightLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            standartRightLabelConstraint = $0.right.equalToSuperview().constraint
        }
        
        rightLabel.snp.prepareConstraints {
            rightWithUnitsConstraint = $0.right.equalToSuperview().offset(-40).constraint
        }
        
        unitsLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalTo(rightLabel.snp.right).offset(5)
        }
        
        standartRightLabelConstraint?.activate()
        rightWithUnitsConstraint?.deactivate()
    }
    
    func updateUnitsVisability() {
        switch cellType {
        case 0:
            unitsLabel.isHidden = true
            standartRightLabelConstraint?.activate()
            rightWithUnitsConstraint?.deactivate()
        default:
            unitsLabel.isHidden = false
            standartRightLabelConstraint?.deactivate()
            rightWithUnitsConstraint?.activate()
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - Prepare for reuse

extension RocketCollectionVerticalCell {
    override func prepareForReuse() {
        cellType = 0
    }
}

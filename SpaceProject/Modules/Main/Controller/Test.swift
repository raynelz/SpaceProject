import UIKit
import SnapKit

final class TestViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let heightSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["m", "ft"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = SpaceAppColor.cellBackground
        segmentControl.selectedSegmentTintColor = SpaceAppColor.cellBackgroundSecondary
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SpaceAppColor.text], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SpaceAppColor.cellTextSeconary!], for: .selected)
        return segmentControl
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "Высота"
        label.textColor = SpaceAppColor.text
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
        view.backgroundColor = SpaceAppColor.backgroundSecondary
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(heightSegmentControl)
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
    }
    
    private func setupActions() {
        heightSegmentControl.addTarget(self, action: #selector(heightSegmentChanged(_:)), for: .valueChanged)
    }
    
    @objc private func heightSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("m selected")
        case 1:
            print("ft selected")
        default:
            break
        }
    }
}

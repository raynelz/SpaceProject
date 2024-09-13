import UIKit
import SnapKit

/// Представление для экрана настроек отображения параметров ракеты
final class RocketSettingsView: UIView {
    // MARK: - UI Components
    
    // Элементы горизонтальных стэков сверху вниз
    private lazy var label1 = createLabels(name: TypeOfMeasurement.Height.description)
    private lazy var segment1 = createSegmentedControl(for: .height)
    
    private lazy var label2 = createLabels(name: TypeOfMeasurement.Diameter.description)
    private lazy var segment2 = createSegmentedControl(for: .diameter)
    
    private lazy var label3 = createLabels(name: TypeOfMeasurement.Weight.description)
    private lazy var segment3 = createSegmentedControl(for: .weight)
    
    // Горизонтальные стэки
    private lazy var stack1: UIStackView = makeHorizontalStack(elements: [label1, segment1])
    private lazy var stack2: UIStackView = makeHorizontalStack(elements: [label2, segment2])
    private lazy var stack3: UIStackView = makeHorizontalStack(elements: [label3, segment3])
    
    // Вертикальный стэк
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stack1, stack2, stack3])
        stack.axis = .vertical
        stack.spacing = 30
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
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
    
    // MARK: - Public Methods
    /// Возвращает массив всех сегментированных контролов на экране
    func getSegmentedControls() -> [UISegmentedControl] {
        return [segment1, segment2, segment3]
    }
}

// MARK: - Private Methods

private extension RocketSettingsView {
    // MARK: View Setup
    
    func setupViews() {
        addSubview(verticalStack)
    }
    
    // MARK: Appearance Configuration
    
    func setupAppearance() {
        backgroundColor = SpaceAppColor.background
    }
    
    // MARK: Layout Configuration
    
    func setupLayout() {
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    // MARK: Label Creation
    
    func createLabels(name: String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.textColor = SpaceAppColor.text
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    // MARK: StackView Creation
    
    func makeHorizontalStack(elements: [UIView], spacing: CGFloat = 10, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fillEqually) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: elements)
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }
    
    // MARK: Segmented Control Creation
    
    func createSegmentedControl(for measurementType: MeasurementType) -> UISegmentedControl {
        let items: [String]
        switch measurementType {
        case .height:
            items = [TypeOfMeasurement.Height.meters, TypeOfMeasurement.Height.feet]
        case .diameter:
            items = [TypeOfMeasurement.Diameter.meters, TypeOfMeasurement.Diameter.feet]
        case .weight:
            items = [TypeOfMeasurement.Weight.kilograms, TypeOfMeasurement.Weight.pounds]
        }
        
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = SpaceAppColor.cellBackground
        segmentControl.selectedSegmentTintColor = SpaceAppColor.cellBackgroundSecondary
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SpaceAppColor.text], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SpaceAppColor.cellTextSeconary!], for: .selected)
        return segmentControl
    }
}

// MARK: - MeasurementType Enum
/// Перечисление типов измерений для сегментированных контролов
private enum MeasurementType {
    case height
    case diameter
    case weight
}

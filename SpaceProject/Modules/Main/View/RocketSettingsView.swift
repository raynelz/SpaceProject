import UIKit
import SnapKit

/// Представление для экрана настроек отображения параметров ракеты
final class RocketSettingsView: UIView {
    // MARK: - UI Components
    
    // Элементы горизонтальных стэков сверху вниз
    private lazy var label1 = createLabels(name: "Высота")
    private lazy var segment1 = createSegmentedControl(typeOfMeasurement: .height)
    
    private lazy var label2 = createLabels(name: "Диаметр")
    private lazy var segment2 = createSegmentedControl(typeOfMeasurement: .height)
    
    private lazy var label3 = createLabels(name: "Масса")
    private lazy var segment3 = createSegmentedControl(typeOfMeasurement: .weight)
    
    private lazy var label4 = createLabels(name: "Полезная загрузка")
    private lazy var segment4 = createSegmentedControl(typeOfMeasurement: .weight)
    
    // Горизонтальные стэки
    private lazy var stack1: UIStackView = makeHorizontalStack(elements: [label1, segment1])
    private lazy var stack2: UIStackView = makeHorizontalStack(elements: [label2, segment2])
    private lazy var stack3: UIStackView = makeHorizontalStack(elements: [label3, segment3])
    private lazy var stack4: UIStackView = makeHorizontalStack(elements: [label4, segment4])
    
    // Вертикальный стэк
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stack1, stack2, stack3, stack4])
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
        return [segment1, segment2, segment3, segment4]
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
    
    // MARK:  Segmented Control Creation
    
    func createSegmentedControl(typeOfMeasurement: TypeOfMeasurement) -> UISegmentedControl {
        let items: [String]
        switch typeOfMeasurement {
        case .height:
            items = ["m", "ft"]
        case .weight:
            items = ["kg", "lb"]
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


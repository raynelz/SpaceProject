//
//  RocketSettingsViewController.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 22.08.2024.
//

import UIKit

protocol RocketSettingsViewControllerDelegate: AnyObject {
    func didSettingsChange(diameterStatus: Bool, heightStatus: Bool, weightStatus: Bool)
}

/// Контроллер для экрана настроек отображения параметров ракеты.
/// Управляет пользовательским интерфейсом для изменения и настройки параметров ракеты.
final class RocketSettingsViewController: GenericViewController<RocketSettingsView> {
    /// Переменная, отвечающая за текущий статус отображения диаметра.
    /// По умолчанию равна `false`. Используется для переключения единиц измерения (например, между метрами и футами).
    var diameterStatusDefault = false
    /// Переменная, отвечающая за текущий статус отображения высоты.
    /// По умолчанию равна `false`. Используется для переключения единиц измерения (например, между метрами и футами).
    var heightStatusDefault = false
    /// Переменная, отвечающая за текущий статус отображения веса.
    /// По умолчанию равна `false`. Используется для переключения единиц измерения (например, между килограммами и фунтами).
    var weightStatusDefault = false

    weak var delegate: RocketSettingsViewControllerDelegate?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSegmentsBehavior()
    }
}

//MARK: - Private Methods
private extension RocketSettingsViewController {
    //MARK: - Setup Navigation Bar
    
    func setupNavigationBar() {
        title = "Настройки"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = SpaceAppColor.background
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: SpaceAppColor.textSecondary!
        ]
        
        navigationController?.navigationBar.tintColor = SpaceAppColor.background
        
        let rightButton = UIBarButtonItem(
            title: "Закрыть",
            style: .done,
            target: self,
            action: #selector(closeButtonTapped)
        )
        
        rightButton.tintColor = SpaceAppColor.textSecondary
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func closeButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    func setupSegmentsBehavior() {
            let segments = rootView.getSegmentedControls()
            segments.diameter.tag = 0
            segments.height.tag = 1
            segments.weight.tag = 2
            
            for segment in [segments.diameter, segments.height, segments.weight] {
                segment.addTarget(self, action: #selector(segmentChange(_:)), for: .valueChanged)
            }
        }
        @objc func segmentChange(_ sender: UISegmentedControl) {
            switch sender.tag {
            case 0:
                diameterStatusDefault.toggle()
                print("DiameterChange: \(diameterStatusDefault)")
                delegate?.didSettingsChange(diameterStatus: diameterStatusDefault, heightStatus: heightStatusDefault, weightStatus: weightStatusDefault)
            case 1:
                heightStatusDefault.toggle()
                print("HeightChange: \(heightStatusDefault)")
                delegate?.didSettingsChange(diameterStatus: diameterStatusDefault, heightStatus: heightStatusDefault, weightStatus: weightStatusDefault)
            case 2:
                weightStatusDefault.toggle()
                print("WeightChange: \(weightStatusDefault)")
                delegate?.didSettingsChange(diameterStatus: diameterStatusDefault, heightStatus: heightStatusDefault, weightStatus: weightStatusDefault)
            default:
                break
            }
        }
}

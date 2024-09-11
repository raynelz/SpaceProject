//
//  RocketSettingsViewController.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 22.08.2024.
//

import UIKit

/// Контроллер для экрана настроек отображения параметров ракеты.
/// Управляет пользовательским интерфейсом для изменения и настройки параметров ракеты.
final class RocketSettingsViewController: GenericViewController<RocketSettingsView> {

    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
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
//        let segments = rootView.getSegmentedControls()
    }
}

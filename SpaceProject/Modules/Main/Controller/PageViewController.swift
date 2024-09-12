//
//  PageViewController.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 12.09.2024.
//

import UIKit

final class PageViewController: UIPageViewController {

    
    private var mainVCs: [MainViewController] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControlAppearance()
        self.dataSource = self
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            await fetchData()
        }
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        view.backgroundColor = SpaceAppColor.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Private Methods

private extension PageViewController {
    func fetchData() async {
        let rocketSersvice = RocketSettingsService()
        let json: [String: Any] = [:]
        do {
            let decodedData = try await rocketSersvice.getRocketSettings(json: json)
            let cellData = self.turnToRocketCollectionModel(decodedData)

            DispatchQueue.main.async {
                self.mainVCs = self.makeVCs(dataForVC: cellData)

                self.setViewControllers([self.mainVCs[0]], direction: .forward, animated: true)
            }
        } catch {
            print("Функция упала: \(error.localizedDescription)")
        }
    }
    
    func turnToRocketCollectionModel(_ decodedData: [RocketSettingsResponse]) -> [[RocketCollectionModel.CellData]] {
        var cellDataArray: [[RocketCollectionModel.CellData]] = []
        for decodedElement in decodedData {
            var cellData: [RocketCollectionModel.CellData] = [
                RocketCollectionModel.CellData(sectionNumber: 0, mainText: String(decodedElement.height.meters), secondaryText: TypeOfMeasurement.Height.description, unitsOfMeasurement: TypeOfMeasurement.Height.meters),
                RocketCollectionModel.CellData(sectionNumber: 0, mainText: String(decodedElement.diameter.meters), secondaryText: TypeOfMeasurement.Diameter.description, unitsOfMeasurement: TypeOfMeasurement.Diameter.meters),
                RocketCollectionModel.CellData(sectionNumber: 0, mainText: String(decodedElement.mass.kg), secondaryText: TypeOfMeasurement.Weight.description, unitsOfMeasurement: TypeOfMeasurement.Weight.kilograms),
                RocketCollectionModel.CellData(sectionNumber: 1, mainText: "Первый запуск", secondaryText: decodedElement.firstFlight, unitsOfMeasurement: nil),
                RocketCollectionModel.CellData(sectionNumber: 1, mainText: "Страна", secondaryText: decodedElement.country, unitsOfMeasurement: nil),
                RocketCollectionModel.CellData(sectionNumber: 1, mainText: "Стоимость", secondaryText: String(decodedElement.costPerLaunch), unitsOfMeasurement: "$"),
                RocketCollectionModel.CellData(sectionNumber: 2, mainText: "Количество двигателей",  secondaryText: String(decodedElement.firstStage.engines), unitsOfMeasurement: ""),
                RocketCollectionModel.CellData(sectionNumber: 2, mainText: "Количество топлива", secondaryText: String(decodedElement.firstStage.fuelAmountTons), unitsOfMeasurement: "ton"),
                RocketCollectionModel.CellData(sectionNumber: 3, mainText: "Количество двигателей",  secondaryText: String(decodedElement.secondStage.engines), unitsOfMeasurement: ""),
                RocketCollectionModel.CellData(sectionNumber: 3, mainText: "Количество топлива", secondaryText: String(decodedElement.secondStage.fuelAmountTons), unitsOfMeasurement: "ton")
            ]
            if let stageOneBurnTime = decodedElement.firstStage.burnTimeSec {
                let elem = RocketCollectionModel.CellData(sectionNumber: 2, mainText: "Время сгорания топлива", secondaryText: String(stageOneBurnTime), unitsOfMeasurement: "сек")
                cellData.append(elem)
            }
            if let stageTwoBurnTime = decodedElement.secondStage.burnTimeSec {
                let elem = RocketCollectionModel.CellData(sectionNumber: 3, mainText: "Время сгорания топлива", secondaryText: String(stageTwoBurnTime), unitsOfMeasurement: "сек")
                cellData.append(elem)
            }
            cellDataArray.append(cellData)
        }
        return cellDataArray
    }
    
    func makeVCs(dataForVC: [[RocketCollectionModel.CellData]]) -> [MainViewController] {
        var mainVCs: [MainViewController] = []
        for cellData in dataForVC {
            let mainVC = MainViewController(data: cellData)
            mainVCs.append(mainVC)
        }
        return mainVCs
    }
    
    func setupPageControlAppearance() {
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = SpaceAppColor.pageIndicatorTintColor
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MainViewController else { return nil }
        if let index = mainVCs.firstIndex(of: viewController) {
            if index > 0 { return mainVCs[index - 1]}
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MainViewController else { return nil }
        if let index = mainVCs.firstIndex(of: viewController) {
            if index < mainVCs.count - 1 {
                return mainVCs[index + 1]
            }
        }
        return nil
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        mainVCs.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}

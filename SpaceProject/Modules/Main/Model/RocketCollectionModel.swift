//
//  RocketCollectionModel.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 21.08.2024.
//
enum RocketCollectionModel {
    struct CellData: Hashable {
        let sectionNumber: Int
        let mainText: String
        let secondaryText: String
        let unitsOfMeasurement: String?
    }
    
    enum SectionType: Int, CaseIterable {
        case specificationInfo
        case additionalInfo
        case firstStageInfo
        case secondStageInfo
        
        var sectionName: String {
            switch self {
            case .specificationInfo:
                return "Технические характеристики"
            case .additionalInfo:
                return "Дополнительная информация"
            case .firstStageInfo:
                return "Первая ступень"
            case .secondStageInfo:
                return "Вторая ступень"
            }
        }
    }
    
    static func getTestData() -> [CellData] {
        [
            CellData(
                sectionNumber: 0,
                mainText: "229.6",
                secondaryText: "Высота",
                unitsOfMeasurement: "ft"
            ),
            CellData(
                sectionNumber: 0,
                mainText: "39.9",
                secondaryText: "Диаметр",
                unitsOfMeasurement: "ft"
            ),
            CellData(
                sectionNumber: 0,
                mainText: "3,125,735",
                secondaryText: "Масса",
                unitsOfMeasurement: "lb"
            ),
            CellData(
                sectionNumber: 0,
                mainText: "Прокоп",
                secondaryText: "Нагрузка",
                unitsOfMeasurement: "фифа"
            ),
            CellData(
                sectionNumber: 1,
                mainText: "Первый запуск",
                secondaryText: "7 февраля, 2018",
                unitsOfMeasurement: nil
            ),
            CellData(
                sectionNumber: 1,
                mainText: "Страна",
                secondaryText: "США",
                unitsOfMeasurement: nil
            ),
            CellData(
                sectionNumber: 1,
                mainText: "Стоимость запуска",
                secondaryText: "$90 млн",
                unitsOfMeasurement: nil
            ),
            CellData(
                sectionNumber: 2,
                mainText: "Количество двигателей",
                secondaryText: "27",
                unitsOfMeasurement: ""
            ),
            CellData(
                sectionNumber: 2,
                mainText: "Количество топлива",
                secondaryText: "308,6",
                unitsOfMeasurement: "ton"
            ),
            CellData(
                sectionNumber: 3,
                mainText: "Треееш",
                secondaryText: "148,0",
                unitsOfMeasurement: "ллулу"
            ),
            CellData(
                sectionNumber: 3,
                mainText: "Опять треееш",
                secondaryText: "16,6",
                unitsOfMeasurement: "=="
            )
        ]
    }
}

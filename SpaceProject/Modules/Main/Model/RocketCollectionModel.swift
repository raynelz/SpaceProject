//
//  RocketCollectionModel.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 21.08.2024.
//

/// Модель коллекции ракеты
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
}

//
//  RocketCollectionModel.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 21.08.2024.
//

/// Модель, представляющая данные для коллекции ракеты
enum RocketCollectionModel {

    /// Структура, содержащая данные для ячеек коллекции
    struct CellData: Hashable {
        /// Номер секции
        let sectionNumber: Int
        /// Основной текст ячейки
        let mainText: String
        /// Дополнительный текст ячейки
        let secondaryText: String
        /// Единицы измерения (необязательное поле)
        let unitsOfMeasurement: String?
    }
    
    /// Структура, содержащая данные для заголовка секции
    struct HeaderData {
        /// Изображение ракеты в формате строки (URL)
        let image: String
        /// Название ракеты
        let rocketName: String
    }
    
    /// Перечисление, представляющее типы секций коллекции
    enum SectionType: Int, CaseIterable {
        /// Секция с техническими характеристиками
        case specificationInfo
        /// Секция с дополнительной информацией
        case additionalInfo
        /// Секция с информацией о первой ступени
        case firstStageInfo
        /// Секция с информацией о второй ступени
        case secondStageInfo
        
        /// Название секции, возвращаемое в зависимости от типа
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

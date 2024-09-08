//
//  API.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 07.09.2024.
//

import Foundation

/// Пространство имен для работы с API SpaceX
enum API {
    /// Базовый URL
    static let baseURL: String = "https://api.spacexdata.com/v4/"
    /// Конечные точки API, доступные для запросов
    enum Endpoints {
        /// Конечная точка для получения информации о ракетах
        static let rockets = "rockets"
        /// Конечная точка для получения информации о запусках
        static let launches = "launches"
    }
}

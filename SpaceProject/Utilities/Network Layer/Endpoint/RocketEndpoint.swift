//
//  RocketEndpoint.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 07.09.2024.
//

import Foundation

/// Определяет конечные точки API для работы с ракетами
enum RocketEndpoint: Endpoint {
    /// Запрос для получения информации о ракетах
    /// - Parameter json: Данные для запроса в формате JSON
    case rockets(json: JSON)
    /// Возвращает путь для запроса в API
    var path: String {
        switch self {
        case .rockets:
            return API.Endpoints.rockets
        }
    }
    /// Возвращает HTTP-метод для запроса (GET, POST и т.д.)
    var method: RequestMethod {
        switch self {
        case .rockets:
            return .get
        }
    }
    /// Возвращает заголовки для запроса (если есть)
    var header: [String: String]? {
        return nil
    }
    /// Возвращает параметры для запроса (если есть)
    var parameters: JSON? {
        switch self {
        case .rockets(let json):
            return json
        }
    }
}

//
//  LaunchEndpoint.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 07.09.2024.
//

import Foundation

/// Определяет конечные точки API для работы с запусками ракет
enum LaunchEndpoint: Endpoint {
    /// Запрос для получения списка запусков
    /// - Parameter json: Данные для запроса в формате JSON
    case launches(json: JSON)
    /// Возвращает путь для запроса в API
    var path: String {
        switch self {
        case .launches:
            return API.Endpoints.launches
        }
    }
    /// Возвращает HTTP-метод для запроса (GET, POST и т.д.)
    var method: RequestMethod {
        switch self {
        case .launches:
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
        case .launches(let json):
            return json
        }
    }
}

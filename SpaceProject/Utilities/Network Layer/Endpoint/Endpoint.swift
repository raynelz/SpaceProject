//
//  Endpoint.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 07.09.2024.
//

import Foundation

typealias JSON = [String: Any]

/// Конечная точка запроса
protocol Endpoint {
    /// путь к конечной точке
    var path: String { get }

    /// метод запроса
    var method: RequestMethod { get }

    /// заголовок запроса
    var header: [String: String]? { get }

    /// параметры запроса
    var parameters: JSON? { get }
}

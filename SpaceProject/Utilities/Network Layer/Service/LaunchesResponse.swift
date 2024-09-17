//
//  LaunchesResponse.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 03.09.2024.
//

/// Протокол сервиса для получения данных о запусках ракет
protocol LaunchesServiceProtocol {

    /// Получает список запусков ракет
    /// - Parameter json: данные в формате JSON для запроса
    /// - Returns: ответ от сервера с данными о запусках
    func getLaunches(json: JSON) async throws -> [LaunchesResponse]
}

/// Реализация сервиса для получения данных о запусках ракет
final class LaunchesService: Request, LaunchesServiceProtocol {

    /// Получает список запусков ракет
    func getLaunches(json: JSON) async throws -> [LaunchesResponse] {
        return try await sendRequest(
            endpoint: LaunchEndpoint.launches(json: json),
            responseModel: [LaunchesResponse].self
        )
    }
}

/// Апи для запусков
struct LaunchesResponse: Decodable {
    /// Название запуска
    let name: String
    /// Дата запуска
    let dateUnix: Double
    /// Успешность запуска
    let success: Bool?
}


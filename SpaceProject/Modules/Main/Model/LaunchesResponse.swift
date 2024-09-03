//
//  LaunchesResponse.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 03.09.2024.
//

/// Апи для запусков
struct LaunchesResponse: Decodable {
    /// Название запуска
    let name: String
    /// Дата запуска
    let dateUtc: String
    /// Успешность запуска
    let success: Bool?
}


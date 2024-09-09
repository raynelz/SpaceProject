//
//  RequestEncoder.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 08.09.2024.
//

import Foundation

/// Декодировщик запроса
class RequestEncoder {
    static func json(parameters: [String: Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print(error)
            return nil
        }
    }
}

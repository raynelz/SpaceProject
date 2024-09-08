//
//  RocketEndpoint.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 07.09.2024.
//

import Foundation


enum RocketEndpoint: Endpoint {
    case rockets(json: JSON)
    
    var path: String {
        switch self {
        case .rockets:
            return API.Endpoints.rockets
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .rockets:
            return .get
        }
    }
    
    var header: [String : String]? { return nil }
    
    var parameters: JSON? {
        switch self {
        case .rockets(let json):
            return json
        }
    }
}

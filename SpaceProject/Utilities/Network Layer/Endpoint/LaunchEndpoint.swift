//
//  LaunchEndpoint.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 07.09.2024.
//

import Foundation

enum LauncgEndpoint: Endpoint {
    case launches(json: JSON)
    
    var path: String {
        switch self {
        case .launches:
            return API.Endpoints.launches
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .launches:
            return .get
        }
    }
    
    var header: [String : String]? { return nil }
    
    var parameters: JSON? {
        switch self {
        case .launches(let json):
            return json
        }
    }
    
    
}

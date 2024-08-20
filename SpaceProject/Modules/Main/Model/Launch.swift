//
//  Launch.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 19.08.2024.
//

import Foundation

struct Launch {
    let name: String
    let date: String
    let launchIs: Bool
}

func makeLaunches() -> [Launch] {
    [
    Launch(name: "Falcon-9", date: "12 august 2019", launchIs: true),
    Launch(name: "Nasa Space Ship", date: "28 september 2020", launchIs: false),
    Launch(name: "Bobir kurwa", date: "30 august 2004", launchIs: true)
    ]
}

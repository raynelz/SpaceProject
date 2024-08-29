//
//  MockData.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 23.08.2024.
//

enum MockData {
    static let collectionMockData = [
        RocketCollectionModel.CellData(
            sectionNumber: 0,
            mainText: "229.6",
            secondaryText: "Высота",
            unitsOfMeasurement: "ft"
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 0,
            mainText: "39.9",
            secondaryText: "Диаметр",
            unitsOfMeasurement: "ft"
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 0,
            mainText: "3,125,735",
            secondaryText: "Масса",
            unitsOfMeasurement: "lb"
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 0,
            mainText: "Прокоп",
            secondaryText: "Нагрузка",
            unitsOfMeasurement: "фифа"
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 1,
            mainText: "Первый запуск",
            secondaryText: "7 февраля, 2018",
            unitsOfMeasurement: nil
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 1,
            mainText: "Страна",
            secondaryText: "США",
            unitsOfMeasurement: nil
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 1,
            mainText: "Стоимость запуска",
            secondaryText: "$90 млн",
            unitsOfMeasurement: nil
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 2,
            mainText: "Количество двигателей",
            secondaryText: "27",
            unitsOfMeasurement: ""
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 2,
            mainText: "Количество топлива",
            secondaryText: "308,6",
            unitsOfMeasurement: "ton"
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 3,
            mainText: "Треееш",
            secondaryText: "148,0",
            unitsOfMeasurement: "ллулу"
        ),
        RocketCollectionModel.CellData(
            sectionNumber: 3,
            mainText: "Опять треееш",
            secondaryText: "16,6",
            unitsOfMeasurement: "=="
        )
    ]
}


struct LaunchMockTest {
    static let launches: [Launch] =
    [
        Launch(name: "Falcon-9", date: "12 august 2019", launchIs: true),
        Launch(name: "Nasa Space Ship", date: "28 september 2020", launchIs: false),
        Launch(name: "Bobir kurwa", date: "30 august 2004", launchIs: true),
        Launch(name: "Bobir kurwa", date: "30 august 2004", launchIs: true),
        Launch(name: "Bobir kurwa", date: "30 august 2004", launchIs: true),
        Launch(name: "Bobir kurwa", date: "30 august 2004", launchIs: true),
        Launch(name: "Bobir kurwa", date: "30 august 2004", launchIs: true)
    ]
}

//
//  PageViewController.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 12.09.2024.
//

import UIKit

class PageViewController: UIPageViewController {

    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        setViewControllers([MainViewController()], direction: .forward, animated: true)
        view.backgroundColor = SpaceAppColor.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PageViewController {
    
}

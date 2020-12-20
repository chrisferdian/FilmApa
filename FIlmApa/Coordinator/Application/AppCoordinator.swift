//
//  AppCoordinator.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 16/12/20.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let viewController = GenresTVC()
        let viewModel = GenresViewModel()
        viewController.coordinator = self
        viewController.viewModel = viewModel
        viewModel.didSelectedGenre = { id in
            self.startDiscover(with: id)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
extension AppCoordinator {
    func startDiscover(with id: Int) {
        let discoverCoordinator = DiscoverCoordinator(navigationController: navigationController, id: id)
        discoverCoordinator.start()
    }
}


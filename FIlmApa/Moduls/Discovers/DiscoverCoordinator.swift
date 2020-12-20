//
//  DiscoverCoordinator.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import UIKit

class DiscoverCoordinator: Coordinator {
   
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    private var id: Int = 0
    
    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let discoverVC = DiscoverVC()
        let viewModel  = DiscoverViewModel(genreId: id)
        viewModel.didSelectedMovie = { movie in
            self.startDetail(movie: movie)
        }
        discoverVC.viewModel = viewModel
        navigationController.pushViewController(discoverVC, animated: true)
    }
}

extension DiscoverCoordinator {
    func startDetail(movie: Movie) {
        let coordinator = DetailCoordinator(navigationController: self.navigationController, movie: movie)
        coordinator.start()
    }
}

//
//  DetailCoordinator.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import UIKit

class DetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var movie: Movie!
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start() {
        let viewModel = DetailViewModel()
        let viewController = DetailVC()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8, execute: {
            viewModel.movie = self.movie
        })
    }
}

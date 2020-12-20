//
//  Coordinator.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 16/12/20.
//

import Foundation
import UIKit
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

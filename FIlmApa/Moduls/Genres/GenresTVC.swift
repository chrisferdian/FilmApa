//
//  GenresTVC.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 16/12/20.
//

import UIKit

class GenresTVC: UITableViewController {
        
    weak var coordinator: AppCoordinator?
    var viewModel: GenresViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: GenreCell.self)
        tableView.tableFooterView = UIView()
        viewModel?.changeHandler = { changes in
            switch changes {
            case .updateDataModel:
                self.tableView.reloadData()
            case .error(let message):
                print(message)
            case .loaderStart:
                break
            case .loaderEnd:
                break
            }
        }
        viewModel?.processGetGenres()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.genres.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: GenreCell.self, for: indexPath)
        if let genre = viewModel?.genres[indexPath.row] {
            cell.bind(with: genre)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.processShowDiscover(indexPath: indexPath)
    }
}

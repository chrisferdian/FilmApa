//
//  DiscoverVC.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import UIKit

class DiscoverVC: UIViewController {
    
    weak var viewModel: DiscoverViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(cellType: DiscoverCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        bindViewModel()
        viewModel?.processGetDiscovers()
    }
    
    func bindViewModel() {
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
    }
    
}

extension DiscoverVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DiscoverCell.self, for: indexPath)
        if let movie = viewModel?.movies[indexPath.row] {
            cell.bind(with: movie)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // need to pass your indexpath then it showing your indicator at bottom
        tableView.addLoading(indexPath) {
            self.viewModel?.processGetDiscovers()
            tableView.stopLoading() // stop your indicator
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.processShowDetail(indexPath: indexPath)
    }
}

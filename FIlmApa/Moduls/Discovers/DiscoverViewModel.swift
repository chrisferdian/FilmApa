//
//  DiscoverViewModel.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import Foundation

class DiscoverViewModel: BaseViewModel {
    var changeHandler: ((BaseViewModelChange) -> Void)?
    private var id: Int?
    var manager: APIClient = APIClient.shared
    private var responseHandler: ((Swift.Result<DiscoverResponse, Error>) -> Void)!
    var movies: [Movie] = [] {
        didSet {
            changeHandler?(.updateDataModel)
        }
    }
    private var page: Int = 0
    private var haveNextPage: Bool = true
    var didSelectedMovie: ((_ movie: Movie) -> Void)?

    init(genreId: Int) {
        self.id = genreId
        responseHandler = { result in
            switch result {
            case .success(let response):
                self.page = response.page
                if self.page == response.totalPages {
                    self.haveNextPage = false
                }
                self.movies.append(contentsOf: response.results)
            case .failure(let error):
                print(#function+error.localizedDescription)
            }
        }
    }
    func processShowDetail(indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.didSelectedMovie?(movie)
    }
    func processGetDiscovers() {
        if !haveNextPage {
            return
        }
        guard let id = id else { return }
        self.manager.request(route: .discovers(genreId: id, page: page + 1), completion: responseHandler)
    }
}

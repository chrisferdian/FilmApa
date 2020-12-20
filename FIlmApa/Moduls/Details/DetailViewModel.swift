//
//  DetailViewModel.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import Foundation

class DetailViewModel: BaseViewModel {
    var manager: APIClient = APIClient.shared
    var changeHandler: ((BaseViewModelChange) -> Void)?
    var changeHandlerReviews: ((BaseViewModelChange) -> Void)?
    var changeHandlerVideos: ((BaseViewModelChange) -> Void)?
    var changeHandlerCasters: ((BaseViewModelChange) -> Void)?

    var isShowingViewAllReviews: ((Bool) -> Void)?

    private var reviewsHandler: ((Swift.Result<ResponseReviews, Error>) -> Void)!
    private var videosHandler: ((Swift.Result<ResponseVideos, Error>) -> Void)!
    private var creditsHandler: ((Swift.Result<ResponseCredit, Error>) -> Void)!

    var movie: Movie? {
        didSet {
            changeHandler?(.updateDataModel)
        }
    }
    
    var reviews: [Review]? {
        didSet {
            changeHandlerReviews?(.updateDataModel)
        }
    }
    var videos: [MovieVideo]? {
        didSet {
            changeHandlerVideos?(.updateDataModel)
        }
    }
    var casters: [Cast]? {
        didSet {
            changeHandlerCasters?(.updateDataModel)
        }
    }
    init() {
        videosHandler = { response in
            switch response {
            case .success(let result):
                self.videos = result.results
            case .failure(let error):
                self.changeHandlerVideos?(.error(message: error.localizedDescription))
                print(error.localizedDescription)
            }
        }
        reviewsHandler = { response in
            switch response {
            case .success(let result):
                if result.totalPages ?? 0 > 1 {
                    self.isShowingViewAllReviews?(true)
                }
                self.reviews = result.results ?? []
            case .failure(let error):
                self.changeHandlerReviews?(.error(message: error.localizedDescription))
            }
        }
        creditsHandler = { response in
            switch response {
            case .success(let result):
                self.casters = result.cast
            case .failure(let error):
                self.changeHandlerCasters?(.error(message: error.localizedDescription))
            }
        }
    }
    func processGetCasters() {
        guard let movieId = movie?.id.toString() else { return }
        manager.request(route: .credits(movieId: movieId), completion: creditsHandler)
    }
    func processGetReviews() {
        guard let movieId = movie?.id.toString() else { return }
        manager.request(route: .reviews(movieId: movieId, page: 1), completion: reviewsHandler)
    }
    func processGetVideos() {
        guard let movieId = movie?.id.toString() else { return }
        manager.request(route: .videos(movieId: movieId), completion: videosHandler)
    }
}

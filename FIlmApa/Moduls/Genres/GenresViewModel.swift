//
//  GenresViewModel.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 16/12/20.
//

import Alamofire
import UIKit

class GenresViewModel: BaseViewModel {
    
    var manager: APIClient = APIClient.shared
    var changeHandler: ((BaseViewModelChange) -> Void)?
    var didSelectedGenre: ((_ id: Int) -> Void)?
    var responseHandler: ((Swift.Result<GenresResponse, Error>) -> Void)!
    var genres: [Genre] = [] {
        didSet {
            changeHandler?(.updateDataModel)
        }
    }
    
    init() {
        self.getData()
    }
    
    func processShowDiscover(indexPath: IndexPath) {
        self.didSelectedGenre?(genres[indexPath.row].id)
    }
    
    private func getData() {
        responseHandler =  { result in
            switch result {
            case .success(let response):
                self.genres.append(contentsOf: response.genres)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func processGetGenres() {
        manager.request(route: .genres, completion: responseHandler)
    }
}

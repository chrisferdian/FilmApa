//
//  BaseViewModel.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import Foundation
protocol BaseViewModel {
    var manager: APIClient { get set}
    var changeHandler: ((BaseViewModelChange) -> Void)? {get set}
//    func emit(_ change: BaseViewModelChange)
}

enum BaseViewModelChange {
    case loaderStart
    case loaderEnd
    case updateDataModel
    case error(message: String)
}

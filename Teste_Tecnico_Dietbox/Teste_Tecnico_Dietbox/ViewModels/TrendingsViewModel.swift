//
//  TrendingsViewModel.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 20/09/21.
//

import UIKit

protocol TrendingsViewModel {
    var page: Int { get }
    var results: [MovieResponseModel] { get }
    var total_pages: Int { get }
    var total_results: Int { get }
}

struct TMDBTrendingsViewModel: TrendingsViewModel {
    let page: Int
    var results: [MovieResponseModel]
    let total_pages: Int
    let total_results: Int

    init(model: TrendingsResponseModel) {
        page = model.page
        results = model.results
        total_pages = model.total_pages
        total_results = model.total_results
    }
}

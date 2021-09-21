//
//  TrendingsResponseModel.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 20/09/21.
//

import Foundation

struct TrendingsResponseModel: Codable {
    var page: Int = 0
    var results: [MovieResponseModel] = []
    var total_pages: Int = 0
    var total_results: Int = 0
}

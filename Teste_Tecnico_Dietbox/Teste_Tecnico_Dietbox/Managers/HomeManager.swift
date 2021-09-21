//
//  HomeManager.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 19/09/21.
//

protocol HomeManager {
    typealias TrendingsCompletion = (TMDBTrendingsViewModel, Error?) -> Void

    func getTrendings(completion: @escaping TrendingsCompletion)
    func searchMovie(_ key: String, completion: @escaping TrendingsCompletion)
}

class TMDBHomeManager: HomeManager {
    var service = TMDBHomeService()
            
    func getTrendings(completion: @escaping TrendingsCompletion) {
        service.getTrendings { result in
            switch result {
            case let .success(trendingsResult):
                if let trendings = trendingsResult {
                    let result = TMDBTrendingsViewModel(model: trendings)
                    completion(result, nil)
                }
                return
            case let .error(error):
                completion(TMDBTrendingsViewModel(model: TrendingsResponseModel()), error)
                return
            }
        }
    }
    
    func searchMovie(_ key: String, completion: @escaping TrendingsCompletion) {
        service.searchMovie(key) { result in
            switch result {
            case let .success(trendingsResult):
                if let trendings = trendingsResult {
                    let result = TMDBTrendingsViewModel(model: trendings)
                    completion(result, nil)
                }
                return
            case let .error(error):
                completion(TMDBTrendingsViewModel(model: TrendingsResponseModel()), error)
                return
            }
        }
    }
}

//
//  HomeService.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 19/09/21.
//

import Moya

protocol HomeService: NetworkService where Target == HomeTarget {
    func getTrendings(handle: @escaping ServiceCompletion<TrendingsResponseModel>)
    func searchMovie(_ key: String, handle: @escaping ServiceCompletion<TrendingsResponseModel>)
}

final class TMDBHomeService: HomeService {
    
    internal let provider: NetworkProvider

    init(provider: NetworkProvider = MoyaProvider<HomeTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])) {
        self.provider = provider
    }
    
    func getTrendings(handle: @escaping ServiceCompletion<TrendingsResponseModel>) {
        request(target: .getTrendings, then: handle)
    }
    
    func searchMovie(_ key: String, handle: @escaping ServiceCompletion<TrendingsResponseModel>) {
        request(target: .searchMovie(key), then: handle)
    }
}

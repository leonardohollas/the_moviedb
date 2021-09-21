//
//  HomeTarget.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 19/09/21.
//

import Moya

enum HomeTarget {
    case getTrendings
    case searchMovie(_ key: String)
}

extension HomeTarget: NetworkTarget {
    var baseURL: URL {
        return NetworkConstants.URLs.baseURL
    }

    var path: String {
        switch self {
            case .getTrendings:
                return "/trending/movie/day"
            case .searchMovie:
                return "/search/movie"
        }
    }
    
    var method: Method {
        switch self {
        case .getTrendings, .searchMovie:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getTrendings:
            return .requestParameters(parameters: ["language":"pt-BR"], encoding: URLEncoding.queryString)
        case let .searchMovie(key):
            return .requestParameters(parameters: ["query": key, "language":"pt-BR"], encoding: URLEncoding.queryString)
        }
    }
}

//
//  NetworkProvider.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 16/09/21.
//

import Moya

enum NetworkResult {
    case success(Data)
    case error(Error)
}

protocol NetworkProvider {
    typealias NetworkHandler = (NetworkResult) -> Void

    func performRequest(for target: NetworkTarget, then handle: @escaping NetworkHandler)
}

extension MoyaProvider: NetworkProvider {
    func performRequest(for target: NetworkTarget, then handle: @escaping NetworkHandler) {
        guard let apiTarget = target as? Target else {
            assertionFailure("target is not of type Target")
            return
        }

        request(apiTarget) { result in
            switch result {
            case let .success(response):
                handle(.success(response.data))
            case let .failure(error):
                handle(.error(error))
            }
        }
    }
}

//
//  NetworkService.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 16/09/21.
//

import Moya

enum ServiceResult<T> {
    case success(T?)
    case error(Error)
}

protocol NetworkService {
    associatedtype Target: NetworkTarget
    typealias ServiceCompletion<T> = (ServiceResult<T>) -> Void

    var provider: NetworkProvider { get }

    func request<T: Decodable>(target: Target, then complete: @escaping ServiceCompletion<T>)
    func request(target: Target, then complete: @escaping ServiceCompletion<Void>)
}

extension NetworkService {
    func request<T: Decodable>(target: Target, then complete: @escaping ServiceCompletion<T>) {
        provider.performRequest(for: target) { result in
            switch result {
            case let .success(data):
                do {
                    let decodedData = try T.decode(from: data)
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("😀 Response: \(json)")
                    }
                    complete(.success(decodedData))
                } catch {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("😩 Response: \(json)")
                    }
                    assertionFailure("\(error)")
                }
            case let .error(error):
                complete(.error(error))
            }
        }
    }

    func request(target: Target, then complete: @escaping ServiceCompletion<Void>) {
        provider.performRequest(for: target) { result in
            switch result {
            case .success:
                complete(.success(nil))
            case let .error(error):
                complete(.error(error))
            }
        }
    }
}

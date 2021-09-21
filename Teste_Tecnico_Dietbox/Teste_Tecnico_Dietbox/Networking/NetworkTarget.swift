//
//  NetworkTarget.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 16/09/21.
//

import Moya

protocol NetworkTarget: TargetType {}

extension NetworkTarget {
    var baseURL: URL { NetworkConstants.URLs.baseURL }

    var sampleData: Data { Data() }

    var headers: [String: String]? { ["Content-Type": "application/json"] }

    var validationType: ValidationType { .successAndRedirectCodes }
}

//
//  NetworkConstants.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 16/09/21.
//

import Foundation

struct NetworkConstants {
    struct URLs {
        static var baseURL: URL {
            guard let url = URL(string: "https://api.themoviedb.org/3?api_key=\(NetworkConstants.apiKey)") else {
                fatalError("Error to convert string url to URL")
            }
            return url
        }
        
        static var smallImageURL = "https://image.tmdb.org/t/p/w200"
        static var imageURL = "https://image.tmdb.org/t/p/w500"
    }
    
    static var apiKey = "a5bc87f9d433f8be6203d3db2609dc35"
}

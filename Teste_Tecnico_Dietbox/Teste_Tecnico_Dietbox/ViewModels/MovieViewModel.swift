//
//  MovieViewModel.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 19/09/21.
//

import UIKit

protocol MovieViewModel {
    var adult: Bool { get }
    var backdrop_path: String { get }
    var genre_ids: [Int] { get }
    var id: Int { get }
    var media_type: String { get }
    var original_language: String { get }
    var original_title: String { get }
    var overview: String { get }
    var popularity: Double { get }
    var poster_path: String { get }
    var release_date: String { get }
    var title: String { get }
    var video: Bool { get }
    var vote_average: Double { get }
    var vote_count: Int { get }
}

struct TMDBMovieViewModel: MovieViewModel {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let media_type: String
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int

    init(model: MovieResponseModel) {
        adult = model.adult ?? false
        backdrop_path = model.backdrop_path ?? ""
        genre_ids = model.genre_ids ?? []
        id = model.id ?? 0
        media_type = model.media_type ?? ""
        original_language = model.original_language ?? ""
        original_title = model.original_title ?? ""
        overview = model.overview ?? ""
        popularity = model.popularity ?? 0
        poster_path = model.poster_path ?? ""
        release_date = model.release_date ?? ""
        title = model.title ?? ""
        video = model.video ?? false
        vote_average = model.vote_average ?? 0
        vote_count = model.vote_count ?? 0
    }
}

//
//  MovieResponseModel.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 19/09/21.
//

import Foundation

struct MovieResponseModel: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var media_type: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}

extension MovieResponseModel {
    mutating func setStoredData(movie: Movie) {
        adult = movie.adult
        backdrop_path = movie.backdrop_path
        id = movie.id
        media_type = movie.media_type
        original_language = movie.original_language
        original_title = movie.original_title
        overview = movie.overview
        popularity = movie.popularity
        poster_path = movie.poster_path
        release_date = movie.release_date
        title = movie.title
        video = movie.video
        vote_average = movie.vote_average
        vote_count = movie.vote_count
    }
}

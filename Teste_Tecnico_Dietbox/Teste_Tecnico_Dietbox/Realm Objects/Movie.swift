//
//  Movie.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 20/09/21.
//

import RealmSwift

class Movie: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var adult: Bool
    @Persisted var backdrop_path: String
    @Persisted var media_type: String
    @Persisted var original_language: String
    @Persisted var original_title: String
    @Persisted var overview: String
    @Persisted var popularity: Double
    @Persisted var poster_path: String
    @Persisted var release_date: String
    @Persisted var title: String
    @Persisted var video: Bool
    @Persisted var vote_average: Double
    @Persisted var vote_count: Int
    
    func setValues(model: MovieResponseModel) {
        adult = model.adult ?? false
        backdrop_path = model.backdrop_path ?? ""
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

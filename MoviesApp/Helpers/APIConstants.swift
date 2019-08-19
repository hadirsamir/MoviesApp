//
//  APIConstants.swift
//  MoviesApp
//
//  Created by ASamir on 6/29/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import Foundation

class MoviesConstants {
    static let API_KEY = "acea91d2bff1c53e6604e4985b6989e2";
    static let MOVIE_URL = "http://api.themoviedb.org/3/discover/movie?api_key=" + API_KEY + "&page="
    static let IMG_BASE_URL = "http://image.tmdb.org/t/p/w92"
}

extension Notification.Name {
    static let fetchingMoviesCompleted = NSNotification.Name("FetchingMoviesCompleted")
}





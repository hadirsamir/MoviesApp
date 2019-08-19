//
//  MoviesResultsBasicModel.swift
//  MoviesApp
//
//  Created by ASamir on 6/28/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import Foundation
struct MoviesResultsBasicModel : Codable{
    var vote_count : Int = 0
    var id : Int = 0
    var video : Bool = false
    var vote_average : Double = 0.0
    var title : String = ""
    var popularity : Double = 0.0
    var poster_path : String = ""
    var original_language : String = ""
    var original_title : String = ""
    var genre_ids :[Int] = []
    var backdrop_path : String = ""
    var adult : Bool = false
    var overview :String = ""
    var release_date : String = ""
}

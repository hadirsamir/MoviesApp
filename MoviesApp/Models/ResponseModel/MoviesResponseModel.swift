//
//  MoviesResponseModel.swift
//  MoviesApp
//
//  Created by ASamir on 6/28/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import Foundation
struct MoviesResponseModel : Codable {
    var page :Int = 0
    var total_result : Int = 0
    var total_pages : Int = 0
    var results : [MoviesResultsBasicModel] = []
}

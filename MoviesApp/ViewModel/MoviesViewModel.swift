//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by ASamir on 6/29/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import Foundation
class MoviesViewModel: NSObject {
    
    var movieObject : MoviesResponseModel = MoviesResponseModel()
    var details : MoviesResultsBasicModel = MoviesResultsBasicModel()
    var movieArray : [MoviesResultsBasicModel] = [MoviesResultsBasicModel]()
    
    override init() {
        super.init()
    }
    //call Api 
    func getData(page : Int = 1){
        APIManager.httpRequest(urlRequest:MoviesConstants.MOVIE_URL + "\(page)" ,completionHandler: { (objectMov,movArray) in
            self.movieObject = objectMov
            self.movieArray += movArray // append to the current movies
            
            // Post notification
            NotificationCenter.default.post(name: .fetchingMoviesCompleted, object: nil)
        })
    }
    
}

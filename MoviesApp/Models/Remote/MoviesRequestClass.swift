//
//  MoviesRequestClass.swift
//  MoviesApp
//
//  Created by ASamir on 6/28/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import Foundation

class APIManager {
    
    static func httpRequest(urlRequest:String,completionHandler:@escaping (_ detilObject:MoviesResponseModel,_ movArray : [MoviesResultsBasicModel])->Void)   {
        var movieObject : MoviesResponseModel = MoviesResponseModel()
        var movie : MoviesResultsBasicModel = MoviesResultsBasicModel()
        var moviesArray : [MoviesResultsBasicModel] = [MoviesResultsBasicModel]()
        
        // Create the url with NSURL
        let url = URL(string: urlRequest)! //change the url
        
        // Create the session object
        let session = URLSession.shared
        
        // Now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        // Create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                // Create json object from data
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                if let recipe = json {
                    movieObject.page = recipe["page"] as! Int
                    movieObject.total_pages = recipe["total_pages"] as! Int
                    movieObject.total_result = recipe["total_results"] as! Int
                    
                    let movieJSONsarray = recipe["results"] as! [[String:Any]]
                    
                    for movieJSON in movieJSONsarray {
                        if let name = movieJSON["title"] as? String{
                            movie.title = name
                        }
                        if let overview = movieJSON["overview"] as? String{
                            movie.overview = overview
                        }
                        if let date = movieJSON["release_date"] as? String{
                            movie.release_date = date
                        }
                        if let posterPath = movieJSON["poster_path"] as? String{
                            movie.poster_path = posterPath
                        }
                        moviesArray.append(movie)
                    }
                    
                    completionHandler(movieObject,moviesArray)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
}




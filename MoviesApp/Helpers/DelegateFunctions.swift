//
//  DelegateFunctions.swift
//  MoviesApp
//
//  Created by ASamir on 7/1/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import Foundation
protocol  OpenImagePicker : class {
    func openImagePicker()
}

protocol AddMoviesNavigation : class {
    func navigateToAddMoviesVC()
}

//
//  SectionHeaderTableViewCell.swift
//  MoviesApp
//
//  Created by ASamir on 6/29/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import UIKit

class SectionHeaderTableViewCell: UITableViewHeaderFooterView  {
    @IBOutlet weak var sectionHeaderLabel : UILabel!
    @IBOutlet weak var sectionMoreBtn : UIButton!
    weak var delegate : AddMoviesNavigation!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.sectionMoreBtn.layer.cornerRadius = 18
        self.sectionMoreBtn.layer.masksToBounds = true
        self.sectionMoreBtn.layer.borderColor = UIColor.white.cgColor
        self.sectionMoreBtn.layer.borderWidth = 1
    }

    @IBAction func navigateToAddMovies(){
        self.delegate.navigateToAddMoviesVC()
    }
}

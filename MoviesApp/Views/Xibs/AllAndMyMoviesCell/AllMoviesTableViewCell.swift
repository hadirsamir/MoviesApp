//
//  AllMoviesTableViewCell.swift
//  MoviesApp
//
//  Created by ASamir on 6/28/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import UIKit

class AllMoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImage : UIImageView!
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieDate : UILabel!
    @IBOutlet weak var movieInfoView : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.movieInfoView.layer.masksToBounds = true
        self.movieInfoView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

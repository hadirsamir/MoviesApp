//
//  NoMoviesTableViewCell.swift
//  MoviesApp
//
//  Created by ASamir on 6/29/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import UIKit

class NoMoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var noMoviesView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.noMoviesView.layer.cornerRadius = 5
        self.noMoviesView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

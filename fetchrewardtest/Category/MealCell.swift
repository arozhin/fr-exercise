//
//  MealCell.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/27/21.
//

import UIKit

class MealCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var thumbnailImageView:UIImageView!

    override func prepareForReuse() {
        thumbnailImageView.image = nil
        nameLabel.text = nil
    }

    func setMeal(name:String, thumbnail:String?) {
        nameLabel.text = name
        if let thumbnailUrl = thumbnail {
            thumbnailImageView.imageFromURL(thumbnailUrl)
            thumbnailImageView.layer.cornerRadius = 6
        }
    }

}

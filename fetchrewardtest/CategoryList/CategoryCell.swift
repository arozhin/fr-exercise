//
//  CategoryCell.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/27/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var descriptionLabel:UILabel!
    @IBOutlet var thumbnailImageView:UIImageView!

    override func prepareForReuse() {
        thumbnailImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
    }

    func setCategory(name:String, description:String, thumbnail:String?) {
        nameLabel.text = name
        descriptionLabel.text = description
        if let thumbnailUrl = thumbnail {
            thumbnailImageView.imageFromURL(thumbnailUrl)
            thumbnailImageView.layer.cornerRadius = 6
        }
    }
}

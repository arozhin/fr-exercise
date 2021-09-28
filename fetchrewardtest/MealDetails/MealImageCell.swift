//
//  MealImageCell.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/27/21.
//

import UIKit

class MealImageCell: UITableViewCell {

    @IBOutlet weak var mealImage: UIImageView!

    func setImageUrl(_ url:String) {
        self.mealImage.imageFromURL(url)
    }

}

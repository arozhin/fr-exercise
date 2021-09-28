//
//  MealDetailsViewModel.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/24/21.
//

import Foundation
import UIKit

enum MealDetailsCellType {
    case mealImageCell
    case instructionsCell
    case ingredientCell
    case watchVideoCell

    func cellIdentifier() -> String {
        switch self {
            case .mealImageCell: return "MealImageCell"
            case .instructionsCell: return "InstructionsCell"
            case .ingredientCell: return "IngredientCell"
            case .watchVideoCell: return "WatchVideoCell"
        }
    }
}

class MealDetailsViewModel : BaseViewModel {

    var mealId:String = ""

    func mealDetailsRouter() -> MealDetailsRouter? {
        return router as? MealDetailsRouter
    }

    override func load() {
        service()?.loadMealDetails(mealId: mealId, completion: { mealDetails, error in
            DispatchQueue.main.async { [self] in
                if error != nil {
                    delegate?.presentAlert(error?.localizedDescription ?? "Error")
                }
                else {
                    delegate?.dataUpdated()
                }
            }
        })
    }

    func title() -> String {
        return mealName()
    }

    func numberOfSections() -> Int {
        return 3 //TODO: check for video availability
    }

    func headerTitle(_ section:Int) -> String? {
        let titles = [0:"Instructions", 1:"Ingredients", 2:"Links"]
        return titles[section]
    }

    func rowsInSection(_ section:Int) -> Int {
        if section == 0 { //Image and instructions
            return 2
        }
        if section == 1 {
            return mealIngredients().count
        }
        if section == 2 { //watch video
            return 1
        }
        return 0
    }

    func mealDetails() -> MealDetails? {
        db()?.mealDetails(mealId)
    }

    func mealName() -> String {
        return mealDetails()?.name ?? ""
    }

    func mealInstructions() -> String {
        return mealDetails()?.instructions ?? ""
    }

    func mealIngredients() -> [(String,String?)] {
        return mealDetails()?.ingredients ?? []
    }

    func mealImageUrl() -> String? {
        return mealDetails()?.imageSrc ?? mealDetails()?.thumbnail
    }

    func mealVideoUrl() -> String? {
        return mealDetails()?.videoUrl
    }

    func watchVideoText() -> String {
        return "Watch Video"
    }

    func cellTypeFor(_ indexPath:IndexPath) -> MealDetailsCellType {
        if indexPath.section == 0 {
            return indexPath.row == 0 ? .mealImageCell : .instructionsCell
        }
        if indexPath.section == 1 {
            return .ingredientCell
        }
        return .watchVideoCell
    }

    func selected(_ indexPath:IndexPath) {
        if cellTypeFor(indexPath) == .watchVideoCell {
            mealDetailsRouter()?.watchVideo(url: mealVideoUrl() ?? "")
        }
    }

}

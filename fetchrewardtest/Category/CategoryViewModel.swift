//
//  CategoryViewModel.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/24/21.
//

import Foundation
import UIKit

class CategoryViewModel : BaseViewModel{

    var name:String = ""

    func categoryRouter() -> CategoryRouter? {
        return router as? CategoryRouter
    }

    override func load() {
        service()?.loadMealList(name: name, completion: { meals, error in
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

    func selected(_ indexPath:IndexPath) {
        categoryRouter()?.presentMeal(mealId: mealId(indexPath))
    }

    func numberOfMeals() -> Int {
        if let meals = db()?.meals(forCategory: name) {
            return meals.count
        }
        return 0
    }

    func mealName(_ indexPath:IndexPath) -> String {
        if let meals = db()?.meals(forCategory: name) {
            return meals[indexPath.row].name
        }
        return ""
    }

    func mealId(_ indexPath:IndexPath) -> String {
        if let meals = db()?.meals(forCategory: name) {
            return meals[indexPath.row].mealId
        }
        return ""
    }

    func mealThumbnail(_ indexPath:IndexPath) -> String? {
        if let meals = db()?.meals(forCategory: name) {
            return meals[indexPath.row].thumbnail
        }
        return nil
    }

    func title() -> String {
        return name
    }

}

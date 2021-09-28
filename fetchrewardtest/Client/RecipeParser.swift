//
//  RecipeParser.swift
//  fetchrewardtest
//
//  Recipe Parser used by the recipe service to
//  create model objects from network responces

import Foundation

class RecipeParser {
    
    func parseCategory(_ dict:[String:Any]) -> Category? {
        let category = Category(from: dict)
        //TODO: validate parsed category
        return category
    }
    
    func parseCategoryList(_ dict:[String:Any]) -> [Category]? {
        guard let caterories = dict["categories"] as? [Any] else {
            return nil
        }
        var newCategoryList:[Category] = []
        for cat in caterories {
            if let cat = cat as? [String : Any] {
                if let category = parseCategory(cat) {
                    newCategoryList.append(category)
                }
            }
        }
        return newCategoryList.sorted { c1, c2 in
            c1.name < c2.name
        }
    }

    func parseMeal(_ dict:[String:Any]) -> Meal? {
        let meal = Meal(from: dict)
        //TODO: validate parsed category
        return meal
    }

    func parseMealList(_ dict:[String:Any]) -> [Meal]? {
        guard let meals = dict["meals"] as? [Any] else {
            return nil
        }
        var newMealList:[Meal] = []
        for meal in meals {
            if let meal = meal as? [String : Any] {
                if let newMeal = parseMeal(meal) {
                    newMealList.append(newMeal)
                }
            }
        }
        return newMealList.sorted { c1, c2 in
            c1.name < c2.name
        }
    }

    func parseMealDetails(_ dict:[String:Any]) -> MealDetails? {
        guard let meals = dict["meals"] as? [Any] else {
            return nil
        }
        if let meal = meals[0] as? [String : Any] {
            return MealDetails(from: meal)
        }
        return nil
    }

}

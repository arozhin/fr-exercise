//
//  RecipeCache.swift
//  fetchrewardtest
//
// Recipe Database: for simplicity arrays and dictionaries
// can be extended with persistance using filesystem or db storage

import Foundation

class RecipeCache {

    var categoryList:[Category] = []
    var categoryLookup:[String:Category] = [:]
    var categoryMealsLookup:[String:[Meal]] = [:]
    var mealDetailsLookup:[String:MealDetails] = [:]

    func save(categories:[Category]) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        categoryList = categories
        categoryLookup.removeAll()
        for category in categoryList {
            categoryLookup[category.name] = category
        }
    }
    
    func save(meals:[Meal], forCategory:String) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        categoryMealsLookup[forCategory] = meals
    }
    
    func save(mealDetails:MealDetails, mealId:String) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        mealDetailsLookup[mealId] = mealDetails
    }
    
    func categories() -> [Category] {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        return categoryList
    }
    
    func category(name:String) -> Category? {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        return categoryLookup[name]
    }
    
    func meals(forCategory:String) -> [Meal] {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        return categoryMealsLookup[forCategory, default: []]
    }
    
    func mealDetails(_ mealId:String) -> MealDetails? {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        return mealDetailsLookup[mealId]
    }
    
    func reset() {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        categoryList.removeAll()
        categoryLookup.removeAll()
        categoryMealsLookup.removeAll()
        mealDetailsLookup.removeAll()
    }
    
}

//
//  RecipeService.swift
//  fetchrewardtest
//
//  Recipe Service is used by the View Model to obtain
//  the recipe data from network or cache/db
//

import Foundation

class RecipeService {
    
    var settings:Settings
    var client:RecipeApiClient
    var cache:RecipeCache
    var parser = RecipeParser()
    
    init(withSettings:Settings, apiClient:RecipeApiClient, recipeCache:RecipeCache) {
        settings = withSettings
        client = apiClient
        cache = recipeCache
    }
    
    func loadCategoryList(completion: @escaping ([Category]?, Error?) -> ()) {
        let cached = cache.categories()
        if cached.count > 0 {
            completion(cached, nil)
            return
        }

        let request = CategoryListRequest()
        client.execute(request: request) {responce, error in
            if error != nil {
                completion(nil, error)
            }
            else {
                if let categories = self.parser.parseCategoryList(responce) {
                    self.cache.save(categories: categories)
                    completion(categories, nil)
                }
            }
        }
    }

    func loadMealList(name:String, completion: @escaping ([Meal]?, Error?) -> ()) {
        let cached = cache.meals(forCategory: name)
        if cached.count > 0 {
            completion(cached, nil)
            return
        }

        let request = CategoryRequest(categoryId: name)
        client.execute(request: request) {responce, error in
            if error != nil {
                completion(nil, error)
            }
            else {
                if let meals = self.parser.parseMealList(responce) {
                    self.cache.save(meals: meals, forCategory: name)
                    completion(meals, nil)
                }
            }
        }
    }

    func loadMealDetails(mealId: String, completion: @escaping (MealDetails?, Error?)->()) {
        if let cached = cache.mealDetails(mealId) {
            completion(cached, nil)
            return
        }

        let request = MealDetailsRequest(mealId: mealId)
        client.execute(request: request) {responce, error in
            if error != nil {
                completion(nil, error)
            }
            else {
                if let mealDetails = self.parser.parseMealDetails(responce) {
                    self.cache.save(mealDetails: mealDetails, mealId: mealId)
                    completion(mealDetails, nil)
                }
            }
        }

    }
}

//
//  Meal.swift
//  fetchrewardtest
//

import Foundation

struct Meal {
    
    var mealId:String
    var name:String
    var thumbnail:String?
    
    //TODO: probably failable init
    init(from dict:[String:Any]) {
        mealId = dict["idMeal",default: ""] as! String
        name = dict["strMeal",default: ""] as! String
        thumbnail = dict["strMealThumb"] as? String
    }
}

struct MealDetails {
    
    var mealId:String
    var name:String
    var thumbnail:String?
    var area:String? = nil
    var imageSrc:String? = nil
    var videoUrl:String? = nil
    var instructions:String? = nil
    var ingredients:[(String,String?)] = []
    
    init(from dict:[String:Any]) {
        mealId = dict["idMeal",default: ""] as! String
        name = dict["strMeal",default: ""] as! String
        thumbnail = dict["strMealThumb"] as? String
        area = dict["strArea"] as? String
        imageSrc = dict["strImageSource"] as? String
        videoUrl = dict["strYoutube"] as? String
        instructions = dict["strInstructions"] as? String
        for ingrNo in 1...20 {
            if let ingredient = dict["strIngredient\(ingrNo)"] as? String {
                let measure = dict["strMeasure\(ingrNo)"] as? String
                if ingredient.count > 0 {
                    ingredients.append((ingredient, measure))
                }
            }
        }
    }
}


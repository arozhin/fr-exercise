//
//  RecipeRequests.swift
//  fetchrewardtest
//
//  Recipe API requests
//

import Foundation

//TODO:concider converting to enum

protocol RecipeApiRequest {
    var command:String {get}
    var httpMethod:String {get}
    var urlParameters:[String:String] {get}
}

struct CategoryListRequest : RecipeApiRequest {
    var command:String { "categories.php" }
    var urlParameters:[String:String] { [:] }
    var httpMethod:String { "GET" }
}

struct CategoryRequest : RecipeApiRequest {
    var categoryId:String
    var command:String { "filter.php" }
    var urlParameters:[String:String] { ["c":categoryId] }
    var httpMethod:String { "GET" }
}

struct MealDetailsRequest : RecipeApiRequest {
    var mealId:String
    var command:String { "lookup.php" }
    var urlParameters:[String:String] { ["i":mealId] }
    var httpMethod:String { "GET" }
}

extension RecipeApiRequest {
    func arguments() -> String {
        var args:[String] = []
        for (k,v) in urlParameters {
            if let arg = k.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let val = v.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                args.append("\(arg)=\(val)")
            }
        }
        if args.count > 0 {
            return "?" + args.joined(separator: "&")
        }
        return ""
    }
}

//
//  RecipeServiceTests.swift
//  fetchrewardtestTests
//
//  Created by Alex Rozhin on 9/28/21.
//

import XCTest

class RecipeServiceTests: XCTestCase {

    class ApiClientMock: RecipeApiClientProtocol {
        func execute(request: RecipeApiRequest, completion: @escaping ([String : Any], Error?) -> ()) {
            if request.command == "lookup.php" {
                let result = [
                    "meals" : [
                        [ "idMeal"  : "1",
                          "strMeal" : "Test Meal",
                          "strIngredient1" : "First Ingredient",
                          "strMeasure1" : "44 kg",
                          "strIngredient2" : "Second Ingredient"
                        ]
                    ]
                ]
                completion(result, nil)
                return
            }
            completion([:], NSError(domain: "Unknown request", code: -1, userInfo: nil))
        }
    }

    var settingsMock = Settings()
    var apiClientMock = ApiClientMock()
    var cacheMock = RecipeCache()

    override func setUpWithError() throws {
        settingsMock = Settings()
        apiClientMock = ApiClientMock()
        cacheMock = RecipeCache()
    }

    override func tearDownWithError() throws {
    }

    func testServiceMealDetails() throws {
        let service = RecipeService(withSettings: settingsMock, apiClient: apiClientMock, recipeCache: cacheMock)
        service.loadMealDetails(mealId: "1") { meal, error in
            XCTAssertEqual(meal?.name, "Test Meal")
            XCTAssertEqual(meal?.ingredients[0].0, "First Ingredient")
            XCTAssertEqual(meal?.ingredients[0].1, "44 kg")
            XCTAssertEqual(meal?.ingredients[1].0, "Second Ingredient")
            XCTAssertNil(meal?.ingredients[1].1)
        }
    }

    func testServiceError() throws {
        let service = RecipeService(withSettings: settingsMock, apiClient: apiClientMock, recipeCache: cacheMock)
        service.loadCategoryList { categories, error in
            XCTAssertNil(categories)
            XCTAssertNotNil(error)
        }
    }

    func testServiceCache() throws {
        let service = RecipeService(withSettings: settingsMock, apiClient: apiClientMock, recipeCache: cacheMock)
        service.loadMealDetails(mealId: "1") { meal, error in
            let md = self.cacheMock.mealDetails("1")
            XCTAssertNotNil(md)
        }
    }


}

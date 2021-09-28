//
//  ViewModelTests.swift
//  fetchrewardtestTests
//
//  Created by Alex Rozhin on 9/28/21.
//

import XCTest

class ViewModelTests: XCTestCase {

    class RecipeServiceMock: RecipeService {

        init() {
            let settings = Settings()
            super.init(withSettings: settings, apiClient: RecipeApiClient(withSettings: settings), recipeCache: RecipeCache())
        }

        override func loadMealDetails(mealId: String, completion: @escaping (MealDetails?, Error?) -> ()) {
            let mealDetails = MealDetails(
                from: [ "idMeal"  : "1",
                        "strMeal" : "Test Meal",
                        "strInstructions" : "Instructions",
                        "strIngredient1" : "First Ingredient",
                        "strMeasure1" : "44 kg"
                ])
            cache.save(mealDetails: mealDetails, mealId: "1")
            completion(mealDetails, nil)
        }
    }

    class MealDetailsViewModelMock: MealDetailsViewModel {
        let serviceMock = RecipeServiceMock()
        override func service() -> RecipeService? {
            return serviceMock
        }
    }

    class StubVmDelegate : BaseViewModelDelegate {
        func dataUpdated() {
        }
        func presentAlert(_ text: String) {
        }
    }

    var vm:MealDetailsViewModelMock!
    var router:MealDetailsRouter!
    var vmDelegate:StubVmDelegate!

    override func setUpWithError() throws {
        router = MealDetailsRouter(withViewController: UIViewController())
        vm = MealDetailsViewModelMock(withRouter: router)
        vmDelegate = StubVmDelegate()
        vm.delegate = vmDelegate
    }

    func testViewModelLoad() throws {
        vm.mealId = "1"
        vm.load()
        XCTAssertEqual(vm.title(), "Test Meal")
        XCTAssertEqual(vm.mealInstructions(), "Instructions")
    }
}

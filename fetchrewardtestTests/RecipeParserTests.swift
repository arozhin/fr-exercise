//
//  RecipeParserTests.swift
//  fetchrewardtestTests
//
//  Created by Alex Rozhin on 9/28/21.
//

import XCTest

class RecipeParserTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testParseCategories() throws {
        let parser = RecipeParser()
        let catDict = ["categories" : [
            ["idCategory" : "1",
             "strCategory": "category 1"],
            ["idCategory" : "2",
             "strCategory": "category 2"]
        ]]
        let catList = parser.parseCategoryList(catDict)
        XCTAssert(catList?.count == 2)
        XCTAssertEqual(catList?[0].name, "category 1")
    }

    func testParseCategoriesFailure() throws {
        let parser = RecipeParser()
        let catList = parser.parseCategoryList([:])
        XCTAssertNil(catList)
    }

}

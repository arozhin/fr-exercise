//
//  CategoryListViewModel.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/24/21.
//

import Foundation
import UIKit

class CategoryListViewModel : BaseViewModel {
    
    func selected(_ indexPath:IndexPath) {
        let name = categoryName(indexPath)
        categoryListRouter()?.presentCategory(name: name)
    }

    func categoryListRouter() -> CategoryListRouter? {
        return router as? CategoryListRouter
    }

    override func load() {
        service()?.loadCategoryList(completion: { categories, error in
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
    
    //view data access
    
    func numberOfCategories() -> Int {
        if let categories = db()?.categories() {
            return categories.count
        }
        return 0
    }

    func categoryName(_ indexPath:IndexPath) -> String {
        if let categories = db()?.categories() {
            return categories[indexPath.row].name
        }
        return ""
    }

    func categoryDescription(_ indexPath:IndexPath) -> String {
        if let categories = db()?.categories() {
            return categories[indexPath.row].description
        }
        return ""
    }

    func categoryThumbnail(_ indexPath:IndexPath) -> String? {
        if let categories = db()?.categories() {
            return categories[indexPath.row].thumbnail
        }
        return nil
    }

    func title() -> String {
        return "Categories"
    }

}

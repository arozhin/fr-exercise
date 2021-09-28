//
//  RecipeRouters.swift
//  fetchrewardtest
//
//  Routers and View Controllers navigation
//

import Foundation
import UIKit
import SafariServices

class BaseRouter {
    var viewController:UIViewController

    init(withViewController:UIViewController) {
        viewController = withViewController
    }

    func navigationController() -> UINavigationController {
        return viewController.navigationController!
    }

    func dismiss() {
        navigationController().popViewController(animated: true)
    }
}

class CategoryListRouter : BaseRouter {

    func presentCategory(name:String) {
        if let vc = viewController.storyboard?
            .instantiateViewController(withIdentifier: "CategoryViewController")
            as? CategoryViewController {
            let router = CategoryRouter(withViewController:vc)
            let vm = CategoryViewModel(withRouter: router)
            vm.name = name
            vc.viewModel = vm
            navigationController().pushViewController(vc, animated: true)
        }
    }

    override func dismiss() {//no dismiss for root vc
    }
}

class CategoryRouter : BaseRouter {

    func presentMeal(mealId:String) {
        if let vc = viewController.storyboard?
            .instantiateViewController(withIdentifier: "MealDetailsViewController")
            as? MealDetailsViewController {
            let router = MealDetailsRouter(withViewController:vc)
            let vm = MealDetailsViewModel(withRouter: router)
            vm.mealId = mealId
            vc.viewModel = vm
            navigationController().pushViewController(vc, animated: true)
        }
    }
}

class MealDetailsRouter : BaseRouter {

    func watchVideo(url:String) {
        if let ytUrl = URL(string: url) {
            //UIApplication.shared.open(ytUrl, options: [:])
            let safariController = SFSafariViewController(url: ytUrl)
            viewController.present(safariController, animated: true)
        }
    }
}

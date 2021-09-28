//
//  BaseViewModel.swift
//  fetchrewardtest
//

import Foundation
import UIKit


protocol BaseViewModelDelegate : AnyObject {
    func dataUpdated()
    func presentAlert(_ text:String)
}

class BaseViewModel {

    var router:BaseRouter
    weak var delegate:BaseViewModelDelegate?

    init(withRouter:BaseRouter) {
        router = withRouter
        if let vc = router.viewController as? BaseViewModelDelegate {
            delegate = vc
        }
    }

    func load() {
    }
    
    func alertRetry() {
        load()
    }

    func alertCancel() {
        router.dismiss()
    }

    func core() -> CoreSession? {
        if let app = UIApplication.shared.delegate as? AppDelegate {
            return app.core
        }
        return nil
    }

    func service() -> RecipeService? {
        return core()?.service
    }

    func db() -> RecipeCache? {
        return core()?.service.cache
    }
}

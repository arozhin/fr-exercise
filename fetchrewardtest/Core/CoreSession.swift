//
//  CoreSession.swift
//  fetchrewardtest
//

import Foundation

class CoreSession {
    var settings = Settings()
    var client:RecipeApiClient
    var service:RecipeService
    var imageCache:ImageCache
    
    init() {
        client = RecipeApiClient(withSettings: settings)
        let cache = RecipeCache()
        service = RecipeService(withSettings: settings,
                                apiClient: client,
                                recipeCache: cache)
        imageCache = ImageCache(limit: settings.imageCacheLimit)
    }
}

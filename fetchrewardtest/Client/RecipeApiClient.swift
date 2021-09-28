//
//  RecipeApiClient.swift
//  fetchrewardtest
//
// API Client makes requests to the backend and
// extracts the JSON responces into collections

import Foundation

class RecipeApiClient {
    var settings:Settings

    init(withSettings:Settings) {
        settings = withSettings
    }
    
    func urlStringFor(request:RecipeApiRequest) -> String {
        return settings.apiBaseUrl + request.command
    }
    
    func execute(request:RecipeApiRequest, completion:@escaping ([String:Any], Error?)->()) {
        guard let rqUrl = url(from: request) else {
            completion([:], self.clientError("Bad URL"))
            return
        }
        let task = urlSession().dataTask(with: rqUrl) { data, urlResponce, error in
            if error != nil {
                completion([:], error)
                return
            }
            let parsingResult = self.parseJson(data)
            if let result = parsingResult.0 as? [String:Any] {
                completion(result, nil)
            }
            else {
                completion([:], parsingResult.1 ?? self.clientError("Bad JSON format"))
            }
        }
        task.resume()
    }

    func url(from request:RecipeApiRequest) -> URL? {
        return URL(string: settings.apiBaseUrl + request.command + request.arguments())
    }

    func urlSession() -> URLSession {
        return URLSession.shared
    }

    func parseJson(_ data:Data?) -> (Any?, NSError?) {
        guard let data = data else {
            return (nil, clientError("No Data in network response"))
        }
        do {
            if let obj = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                return (obj, nil)
            }
            else {
                return (nil, clientError("Bad JSON format"))
            }
        } catch let error as NSError {
            return (nil, error)
        }
    }

    func clientError(_ desc:String) -> NSError {
        NSError(domain: "Parse", code: -1, userInfo: ["description" : desc])
    }

}

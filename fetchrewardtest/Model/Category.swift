//
//  Category.swift
//  fetchrewardtest
//

import Foundation

struct Category {
    var categoryId: String
    var name: String
    var description:String
    var thumbnail:String?
    
    init(from dict:[String:Any]) {
        categoryId = dict["idCategory",default: ""] as! String
        name = dict["strCategory",default: ""] as! String
        thumbnail = dict["strCategoryThumb"] as? String
        description = dict["strCategoryDescription",default: ""] as! String
    }
}

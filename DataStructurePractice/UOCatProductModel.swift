//
//  UOCatProductModel.swift
//  DataStructurePractice
//
//  Created by Kevin Taniguchi on 1/17/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

import Foundation
import Decodable

public struct UOCategoryProduct {
    let imageURL: String
    let name: String
    let price: String
}

extension UOCategoryProduct: Decodable {
    public static func decode(json: AnyObject) throws -> UOCategoryProduct {
        return try UOCategoryProduct(
            imageURL: json => "imageURL",
            name: json => "name",
            price: json => "price")
    }
}

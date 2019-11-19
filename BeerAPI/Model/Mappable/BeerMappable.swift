//
//  BeerMappable.swift
//  BeerAPI
//
//  Created by Euijoon Jung on 16/11/2019.
//  Copyright © 2019 Euijoon Jung. All rights reserved.
//

import Foundation
import ObjectMapper

//struct BeerRequestResponse: Mappable {
//    var beerDatas: [BeerData]!
//    init?(map: Map) {}
//    mutating func mapping(map: Map) {
//        self.beerDatas <- map[]
//    }
//}

class BeerData: Mappable {
    var id: Int!
    var name: String!
    var tagline: String!
    var firstBrewed: String!
    var beerDataDescription: String!
    var imageURL: String?
//    var abv: Double
//    var ibu, targetFg, targetOg, ebc: Int
//    var srm: Int
    var ph: Double!
//    var attenuationLevel: Int
//    var volume, boilVolume: BoilVolume
//    var method: Method
//    var ingredients: Ingredients!
    var foodPairing: [String]!
    var brewersTips: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.tagline <- map["tagline"]
        self.firstBrewed <- map["first_brewed"]
        self.beerDataDescription <- map["description"]
        self.imageURL <- map["image_url"]
        self.brewersTips <- map["brewersTips"]
        self.foodPairing <- map["food_pairing"]
//        self.ingredients <- map["ingredients"]
        self.ph <- map["ph"]
        
        
    }
}

extension BeerData {
    func validationCheck() -> Bool {
        guard let imageUrl = self.imageURL, let name = self.name else {
            return false
        }
        return true
    }
}

// MARK: - Ingredients
class Ingredients: Mappable {
    var malt: [Malt]!
    var hops: [Hop]!
    var yeast: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.malt <- map["malt"]
        self.hops <- map["hops"]
        self.yeast <- map["yeast"]
    }
}

// MARK: - Hop
class Hop: Mappable {
    var name: String!
//    var amount: BoilVolume
    var add, attribute: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.add <- map["add"]
        self.attribute <- map["attribute"]
    }
}

// MARK: - Malt
class Malt: Mappable {
    var name: String!
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
    }
    
    
//    var amount: BoilVolume
}

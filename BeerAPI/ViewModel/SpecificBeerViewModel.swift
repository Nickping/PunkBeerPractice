//
//  SpecificBeerViewModel.swift
//  BeerAPI
//
//  Created by Euijoon Jung on 16/11/2019.
//  Copyright © 2019 Euijoon Jung. All rights reserved.
//

import Foundation

class SpecificBeerViewModel {
    
    let selectedBeer: BeerData
    init(beer: BeerData) {
        selectedBeer = beer
    }
}

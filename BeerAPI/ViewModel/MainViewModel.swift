//
//  MainViewModel.swift
//  BeerAPI
//
//  Created by Euijoon Jung on 16/11/2019.
//  Copyright © 2019 Euijoon Jung. All rights reserved.
//

import Foundation
import RxSwift

protocol MainBeerViewDelegate: class {
    func didGetBeers()
    func didGetRandomBeer(_ beer: BeerData)
}

class MainViewModel {
     
    weak var delegate: MainBeerViewDelegate?
    let disposeBag = DisposeBag()
    var beers: [BeerData] = [] {
        didSet {
            delegate?.didGetBeers()
        }
    }
    
    func getBeers(_ page: Int = 1) {
        let obs = BeerApi.requestBeers(page)
            .retry(3)
            .subscribeOn(MainScheduler.instance)
            
            .subscribe(onNext: { (beers: [BeerData]) in
                self.beers.append(contentsOf: beers)
            }, onError: { (error) in
                print(#function + "\(error)")
                
            }, onCompleted: {
                
            }) {
                
        }
        
        obs.disposed(by: disposeBag)
    }
    
    func getRandomBeer() {
        let obs = BeerApi.requestRandomBeer()
        .retry(3)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { (beer: BeerData) in
                self.delegate?.didGetRandomBeer(beer)
            }, onError: { (error) in
                print(#function + "\(error)")
            }, onCompleted: {
                
            }) {
                
        }
        obs.disposed(by: disposeBag)
    }
}

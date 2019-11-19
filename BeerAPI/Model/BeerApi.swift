//
//  BeerApi.swift
//  BeerAPI
//
//  Created by Euijoon Jung on 16/11/2019.
//  Copyright © 2019 Euijoon Jung. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

struct BeerApi {

    static let host: String = "https://api.punkapi.com/v2/beers"

    static func requestBeers(_ page: Int = 1) -> Observable<[BeerData]> {

        return Observable<[BeerData]>.create { (observer) -> Disposable in
            var params: [String: Any] = [:]
            params["page"] = page
            Alamofire.request(host,
                              method: .get,
                              parameters: params,
                              encoding: URLEncoding.default)
                .responseArray { (response: DataResponse<[BeerData]>) in
                    switch response.result {
                        
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let beerData):
                        observer.onNext(beerData)
                    }
            }
            
            return Disposables.create {
//                observer.onCompleted()
            }
        }
    }
    
    static func requestRandomBeer() -> Observable<BeerData> {
        
        return Observable<BeerData>.create { (observer) -> Disposable in
            
            Alamofire.request(BeerApi.host+"/random",
                              method: .get)
                .responseArray { (response: DataResponse<[BeerData]>) in
                    switch response.result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let beerData):
                        
                        observer.onNext(beerData[0])
                    }
            }
            
            return Disposables.create()
        }
    }
    

}


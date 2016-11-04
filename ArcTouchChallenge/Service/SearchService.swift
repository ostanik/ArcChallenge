//
//  SearchService.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 29/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class SearchService: Network {
    static func findRoutesBy(stopName:String, success  : @escaping (Result<Route>) -> (), failure  : ((_ error : Error) -> ())? = nil) {
        let parameters : [String: [String: Any]] = ["params": ["stopName" : "%\(stopName)%"]]
        self.makeAPostFrom(url: APIUrls.routesByStopName, parameters: parameters, success: success, failure: failure);
    }

    static func findStopsBy(routeId:Int, success  : @escaping (Result<Stop>) -> (), failure  : ((_ error : Error) -> ())? = nil) {
        let parameters : [String: [String: Any]] = ["params": ["routeId" : routeId]]
        self.makeAPostFrom(url: APIUrls.findStopsByRoutId, parameters: parameters, success: success, failure: failure);
    }

    static func findDepartureBy(routeId:Int, success  : @escaping (Result<Departure>) -> (), failure  : ((_ error : Error) -> ())? = nil) {
        let parameters : [String: [String: Any]] = ["params": ["routeId" : routeId]]
        self.makeAPostFrom(url: APIUrls.findDeparturesByRouteId, parameters: parameters, success: success, failure: failure);
    }

    private static func makeAPostFrom<T:Mappable>(url: String, parameters : [String: [String: Any]], success  : @escaping (Result<T>) -> (), failure  : ((_ error : Error) -> ())? = nil) {
        Network.manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseObject { (response: DataResponse<Result<T>>) in
            self.processCall(success: success, failure: failure, response: response)
        }
    }

    private static func processCall<T: BaseMappable>(success  : @escaping (T) -> (), failure  : ((_ error : Error) -> ())? = nil, response: DataResponse<T>) {
        switch (response.result) {
        case .success(let value):
            success(value)
            break;
        case .failure(let error):
            if failure != nil {
                failure!(error)
            }
            break
        }
    }
}

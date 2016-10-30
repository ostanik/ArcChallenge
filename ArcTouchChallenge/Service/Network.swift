//
//  File.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 29/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import Foundation
import Alamofire


public class APIUrls {
    static let prefix: String = "https://api.appglu.com/v1/"
    static let queries: String = "\(prefix)queries/"
    static var routesByStopName:String = "\(queries)findRoutesByStopName/run"
    static var findStopsByRoutId:String = "\(queries)findStopsByRouteId/run"
    static var findDeparturesByRouteId:String = "\(queries)findDeparturesByRouteId/run"
}

public class Network {
    static var manager: SessionManager {
        get {
            let m = SessionManager.default
            m.adapter = HeaderAdapter()
            return m
        }
    }
}

open class HeaderAdapter: RequestAdapter {
    fileprivate let user = "WKD4N7YMA1uiM8V"
    fileprivate let password = "DtdTtzMLQlA0hk2C1Yi5pLyVIlAQ68"
    fileprivate let credentialData: Data?
    fileprivate let base64Credentials: String!

    init() {
        credentialData = "\(user):\(password)".data(using: .utf8)
        base64Credentials = credentialData?.base64EncodedString(options: [])
    }

    open func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

        if (urlRequest.url?.absoluteString.hasPrefix(APIUrls.prefix))! {
            urlRequest.setValue("Basic " + base64Credentials, forHTTPHeaderField: "Authorization")
            urlRequest.setValue("staging", forHTTPHeaderField: "X-AppGlu-Environment")
        }
        return urlRequest
    }
}

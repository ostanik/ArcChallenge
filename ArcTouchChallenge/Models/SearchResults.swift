//
//  SearchResults.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 29/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import Foundation
import ObjectMapper

class Result<T: Mappable>: Mappable {
    var rowsAffected: Int?
    var rows: [T]?

    required init?(map: Map){ }

    func mapping(map: Map) {
        rowsAffected <- map["rowsAffected"]
        rows <- map["rows"]
    }
}

class Route: Mappable {
    var id: Int?
    var shortName: Int?
    var longName: String?
    var lastModifiedDate: Date?
    var agencyId: Int?

    required init?(map: Map){}

    func mapping(map: Map) {
        id <- map["id"]
        shortName <- map["shortName"]
        longName <- map["longName"]
        lastModifiedDate <- map["lastModifiedDate"]
        agencyId <- map["agencyId"]
    }
}

class Stop: Mappable {
    var id: Int?
    var name: String?
    var sequence: Int?
    var routeId: Int?

    required init?(map: Map){}

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        sequence <- map["sequence"]
        routeId <- map["route_id"]
    }
}

class Departure: Mappable {
    var id: Int?
    var calendar: String?
    var time: String?

    required init?(map: Map){}

    func mapping(map: Map) {
        id <- map["id"]
        calendar <- map["calendar"]
        time <- map["time"]
    }
}

enum StopPosition {
    case first
    case last
    case middle
}

enum Calendar: String {
    case weekDay = "WEEKDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"
}



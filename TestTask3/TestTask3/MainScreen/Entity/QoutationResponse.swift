//
//  QoutationResponse.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 12/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import ObjectMapper

struct QoutationsResponse {
    var stock: [Qoutation] = []

    init() {
    }
}

extension QoutationsResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        stock <- map["stock"]
    }
}

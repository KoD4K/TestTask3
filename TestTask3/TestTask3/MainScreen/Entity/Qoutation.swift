//
//  Qoutation.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 12/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import ObjectMapper
import RxDataSources

struct Qoutation {
    var name = ""
    var volume:Int = 0
    var price:Price!
}

extension Qoutation: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        volume <- map["volume"]
        price <- map["price"]
    }
}

extension Qoutation: IdentifiableType {
    typealias Identity = String
    
    var identity: Identity {
        return name
    }
}

extension Qoutation: Hashable {
    var hashValue: Int {
        return "\(self.name)".hashValue
    }
}

extension Qoutation: Equatable {
    static func ==(lhs: Qoutation, rhs: Qoutation) -> Bool {
        return lhs.name == rhs.name &&
            lhs.volume == rhs.volume &&
            lhs.price.amount == rhs.price.amount
    }
}

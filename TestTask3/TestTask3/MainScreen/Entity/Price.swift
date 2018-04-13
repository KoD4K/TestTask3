//
//  Price.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 12/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import ObjectMapper

class Price: Mappable {
    
    var currency = ""
    var amount: Double = 0.00
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        currency <- map["currency"]
        amount <- map["amount"]
    }
}

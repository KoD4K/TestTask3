//
//  Request.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 12/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import ObjectMapper

class Request {
    let url = "http://phisix-api3.appspot.com/stocks.json"
    
    required init?(map: Map) {}
    
    init() {}
    
    func mapping(map: Map) {}
}

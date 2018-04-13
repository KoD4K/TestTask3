//
//  DefaultSectionModel.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 13/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import RxDataSources

struct DefaultSectionModel<T: Equatable & IdentifiableType & Hashable> {
    var items: [Item]
    var id: Int = 0
}

extension DefaultSectionModel: AnimatableSectionModelType {
    typealias Item = T
    
    init(original: DefaultSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

extension DefaultSectionModel: IdentifiableType {
    typealias Identity = Int
    
    var identity: Identity {
        return 0
    }
}

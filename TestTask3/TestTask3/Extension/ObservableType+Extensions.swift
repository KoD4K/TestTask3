//
//  ObservableType+Extensions.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 13/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import RxSwift
import ObjectMapper
import Alamofire

extension ObservableType where E: Mappable {
    typealias successBlock = (E) -> ()
    typealias completedBlock = () -> ()
    typealias eventBlock = () -> ()
    typealias finallyBlock = () -> ()
    
    func consume(onEvent: eventBlock? = nil, onSuccess: successBlock? = nil, onCompleted: completedBlock? = nil, finally: finallyBlock? = nil) -> Disposable {
        return subscribe({ (event: Event<E>) in
            switch event {
            case .completed:
                onCompleted?()
            case .next(let element):
                onEvent?()
                onSuccess?(element)
                finally?()
            case .error(let error):
                print(error)
                
                onEvent?()
                                
                finally?()
            }
        })
    }
}

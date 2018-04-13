//
//  Model.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 13/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import RxSwift
import ObjectMapper

class Model {
    
    lazy private var server: Server = {
        return Server()
    }()
    
    lazy private var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    private let qoutationsVariable: Variable<[Qoutation]>
    var timer: DispatchSourceTimer?
    
    init() {
        qoutationsVariable = Variable([])
    }
    
    //MARK: - OBSERVABLE
    
    func qoutationsObservable() -> Observable<[Qoutation]> {
        return qoutationsVariable.asObservable().skip(1).share()
    }
    
    //MARK: - LOAD DATA
    
    func loadQoutations() {
        server.loadQoutations().consume(onSuccess: {
            self.onSuccessItemsLoad(withData: $0)
        }).disposed(by: disposeBag)
    }
    
    func loadQoutationsWith15Sec() {
        startTimer()
    }
    
    internal func onSuccessItemsLoad(withData data: QoutationsResponse) {
        qoutationsVariable.value = data.stock
    }
    
    //MARL: - TIMER
    
    private func startTimer() {
        let queue = DispatchQueue(label: "app.timer", attributes: .concurrent)
        
        timer?.cancel()
        
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .seconds(15), leeway: .milliseconds(100))
        timer?.setEventHandler { [weak self] in
            self?.loadQoutations()
        }
        timer?.resume()
    }
}

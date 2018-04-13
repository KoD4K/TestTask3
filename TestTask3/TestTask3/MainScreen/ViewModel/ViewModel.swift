//
//  ViewModel.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 13/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import RxSwift

class ViewModel {
    private let model: Model
    lazy private var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    let sections: Variable<[DefaultSectionModel<Qoutation>]>
    
    init() {
        self.model = Model()
        sections = Variable([])
        subscribeOnQoutations()
    }
    
    private func subscribeOnQoutations() {
        model.qoutationsObservable().subscribe(onNext: { qoutations in
            self.updateSection(withQoutations: qoutations)
        }).disposed(by: disposeBag)
    }
    
    //MARK: - LOAD QOUTATIONS
    func start() {
        model.loadQoutationsWith15Sec()
    }
    
    func loadOnce() {
        model.loadQoutations()
    }
    
    //MARK: - SHOW QOUTATIONS
    private func updateSection(withQoutations qoutations: [Qoutation]) {
        sections.value = [DefaultSectionModel(items: qoutations, id: 0)]
    }
}

//
//  ViewController.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 12/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ViewController: UIViewController {

    private var tableView: UITableView!
    fileprivate var viewModel: ViewModel!
    
    var dataSource: RxTableViewSectionedReloadDataSource<DefaultSectionModel<Qoutation>>!
    
    lazy private var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel = ViewModel()
    }
    
    //MARK: - LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTableView()
        setTableViewDataSource()
        addReloadButton()
    }
    
    //MARK: - APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.start()
    }
    
    //MARK: - TABLE VIEW
    private func makeTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.registerCellsArray(nibNames: [TableViewCell.nibName])
        
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 50
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setTableViewDataSource() {
        dataSource = configureDataSource()
        
        viewModel.sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func configureDataSource() -> RxTableViewSectionedReloadDataSource<DefaultSectionModel<Qoutation>> {
        let dataSource = RxTableViewSectionedReloadDataSource<DefaultSectionModel<Qoutation>>(
            configureCell:{ (dataSource, table, idxPath, qoutation) in
                self.createCell(for: qoutation, table: table)
        })
        return dataSource
    }
    
    private func createCell(for qoutation: Qoutation, table: UITableView) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: TableViewCell.nibName) as? TableViewCell {
            cell.fill(withQoutation: qoutation)
            return cell
        }
        
        fatalError("Something wrong with cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder aDecoder:) not implemented")
    }
    
    //MARK: - BUTTONS
    private func addReloadButton() {
        let settingsButton = UIButton(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        settingsButton.addTarget(self, action: #selector(reloadButtonPress), for: .touchUpInside)
        settingsButton.setImage(UIImage(named: "Reload"), for: .normal)
        let settingsButtonItem = UIBarButtonItem.init(customView: settingsButton)
        navigationItem.rightBarButtonItem = settingsButtonItem
    }
    
    @objc func reloadButtonPress() {
        viewModel.start()
    }
}

extension ViewController: UITableViewDelegate {
}

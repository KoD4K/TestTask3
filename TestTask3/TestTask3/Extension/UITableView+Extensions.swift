//
//  UITableView+Extensions.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 13/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCellsArray(nibNames:[String]) {
        for nibname in nibNames {
            self.register(UINib.init(nibName: nibname, bundle: nil),
                          forCellReuseIdentifier: nibname)
        }
    }
}

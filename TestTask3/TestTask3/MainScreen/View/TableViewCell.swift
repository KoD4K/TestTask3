//
//  TableViewCell.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 12/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    static let nibName = "TableViewCell"
    
    func fill(withQoutation qoutation:Qoutation) {
        nameLabel.text = qoutation.name
        priceLabel.text = "\(qoutation.volume)"
        amountLabel.text = String(format: "%.2f", qoutation.price.amount)
    }
}

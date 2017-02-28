//
//  ShowTableViewCell.swift
//  ArsStat
//
//  Created by Администратор on 28.02.17.
//  Copyright © 2017 pvt. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var parameterLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

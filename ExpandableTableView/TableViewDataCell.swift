//
//  TableViewDataCell.swift
//  ExpandableTableView
//
//  Created by cyno on 10/23/18.
//  Copyright © 2018 cyno. All rights reserved.
//

import UIKit

class TableViewDataCell: UITableViewCell {
    
    
    
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var title2LabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

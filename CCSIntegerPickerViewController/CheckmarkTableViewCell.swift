//
//  CheckmarkTableViewCell.swift
//  CCSIntegerPickerViewController
//
//  Created by Zhifu Ge on 2018-10-01.
//  Copyright © 2018 Cocoa Swiftly. All rights reserved.
//

import UIKit

class CheckmarkTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        accessoryType = selected ? .checkmark : .none
    }

}

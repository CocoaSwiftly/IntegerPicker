//
//  IntegerPickerTableViewCell.swift
//  CCSIntegerPickerViewController
//
//  Created by Zhifu Ge on 2018-10-01.
//  Copyright © 2018 Cocoa Swiftly. All rights reserved.
//

import UIKit

class IntegerPickerTableViewCell: UITableViewCell {

    public var minValue: Int = 1
    public var maxValue: Int = 60
    public var selectedValueDidChangeTo: ((Int) -> Void)?

    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()

        pickerView.dataSource = self
        pickerView.delegate = self

        contentView.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.0).isActive = true
        contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: pickerView.trailingAnchor, multiplier: 1.0).isActive = true
        pickerView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1.0).isActive = true
        contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: pickerView.bottomAnchor, multiplier: 1.0).isActive = true

        return pickerView
    }()

    func select(value: Int, animated: Bool) {
        pickerView.selectRow(rowInTheMiddle(forSelectedValue: value), inComponent: 0, animated: animated)
    }

}


extension IntegerPickerTableViewCell: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRows
    }

}

extension IntegerPickerTableViewCell: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(selectedValue(forRow: row))"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = selectedValue(forRow: row)
        selectedValueDidChangeTo?(value)
        pickerView.selectRow(rowInTheMiddle(forSelectedValue: value), inComponent: 0, animated: false)
    }

}

// Private helpers
extension IntegerPickerTableViewCell {

    private var numberOfRows: Int { return 10_000 }

    private func selectedValue(forRow row: Int) -> Int {
        return row % (maxValue - minValue + 1) + minValue
    }

    private func rowInTheMiddle(forSelectedValue selectedValue: Int) -> Int {
        let result = numberOfRows / 2 - numberOfRows / 2 % (maxValue - minValue + 1) + selectedValue - minValue
        assert(self.selectedValue(forRow: result) == selectedValue)
        return result
    }

}

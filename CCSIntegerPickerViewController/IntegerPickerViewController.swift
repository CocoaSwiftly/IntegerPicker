//
//  IntegerPickerViewController.swift
//  CCSIntegerPickerViewController
//
//  Created by Zhifu Ge on 2018-10-01.
//  Copyright © 2018 Cocoa Swiftly. All rights reserved.
//

import UIKit

public class IntegerPickerViewController: UIViewController {

    public var minValue: Int = 0
    public var maxValue: Int = 1000
    public var value: Int = 50
    public var presetValueStep: Int = 1
    public var unitNames: UnitNames?
    public var valueDidChangeTo: ((Int) -> Void)?

    private var presetValues: [Int] = []

    private let tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)

    private lazy var customCell: UITableViewCell = {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Custom"

        var detailText = "\(value)"
        if let unitName = unitNames?.unitName(forValue: value) {
            detailText += " \(unitName)"
        }
        cell.detailTextLabel?.text = detailText
        cell.detailTextLabel?.textColor = .red
        return cell
    }()

    private lazy var pickerViewCell: IntegerPickerTableViewCell = {
        let cell = IntegerPickerTableViewCell(style: .default, reuseIdentifier: nil)

        cell.minValue = minValue
        cell.maxValue = maxValue
        cell.select(value: value, animated: false)
        cell.selectedValueDidChangeTo = { [unowned self] newValue in
            self.value = newValue

            var detailText = "\(newValue)"
            if let unitName = self.unitNames?.unitName(forValue: newValue) {
                detailText += " \(unitName)"
            }
            self.customCell.detailTextLabel?.text = detailText

            if let row = self.presetValues.index(of: newValue) {
                let indexPath = IndexPath(row: row, section: 1)
                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            } else {
                self.tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
            }
        }

        return cell
    }()

}

// MARK: - View Controller Life Cycle
extension IntegerPickerViewController {

    override public func loadView() {
        view = tableView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        if presetValues.isEmpty {
            presetValues = Array(stride(from: minValue, through: maxValue, by: presetValueStep))
        }

        tableView.dataSource = self
        tableView.delegate = self

        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveBarButtonItem

        if let row = self.presetValues.index(of: value) {
            let indexPath = IndexPath(row: row, section: 1)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            self.tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
        }
    }

}

// MARK: - Actions
extension IntegerPickerViewController {

    @objc private func save() {
        valueDidChangeTo?(value)
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITableViewDataSource
extension IntegerPickerViewController: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }

        return presetValues.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return customCell
            } else {
                return pickerViewCell
            }
        } else {
            let identifier = String(describing: CheckmarkTableViewCell.self)
            let cell: UITableViewCell
            if let dequeued = tableView.dequeueReusableCell(withIdentifier: identifier) {
                cell = dequeued
            } else {
                cell = CheckmarkTableViewCell(style: .default, reuseIdentifier: identifier)
            }

            let presetValue = presetValues[indexPath.row]

            cell.textLabel?.text = "\(presetValue) \(unitNames?.unitName(forValue: presetValue) ?? "")"

            return cell
        }
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Custom"
        } else if section == 1{
            return "Preset"
        }

        return nil
    }

}


// MARK: - UITableViewDelegate
extension IntegerPickerViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.section != 0 else {
            return nil
        }

        return indexPath
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presetValue = presetValues[indexPath.row]

        pickerViewCell.select(value: presetValue, animated: true)

        var detailText = "\(presetValue)"
        if let unitName = unitNames?.unitName(forValue: presetValue) {
            detailText += " \(unitName)"
        }
        customCell.detailTextLabel?.text = detailText

        value = presetValue
    }

}



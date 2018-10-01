//
//  ViewController.swift
//  Example
//
//  Created by Zhifu Ge on 2018-10-01.
//  Copyright © 2018 Cocoa Swiftly. All rights reserved.
//

import UIKit
import CCSIntegerPickerViewController

class ViewController: UIViewController {

    private var integer = 0 {
        didSet {
            label.text = integer.description
            label.sizeToFit()
        }
    }

    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.text = integer.description
        label.sizeToFit()

        let editBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                target: self,
                                                action: #selector(showIntegerPicker))
        navigationItem.rightBarButtonItem = editBarButtonItem
    }

}

extension ViewController {

    @objc private func showIntegerPicker() {
        let integerPickerViewController = IntegerPickerViewController()
        integerPickerViewController.presetValueStep = 10
        integerPickerViewController.valueDidChangeTo = { newValue in
            self.integer = newValue
        }

        navigationController?.pushViewController(integerPickerViewController, animated: true)
    }

}


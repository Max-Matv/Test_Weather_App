//
//  UITableViewCell+Reuseidentifire.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 7.12.22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifire: String {
        String(describing: self)
    }
}

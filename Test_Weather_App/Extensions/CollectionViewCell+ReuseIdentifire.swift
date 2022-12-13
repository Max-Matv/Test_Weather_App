//
//  CollectionViewCell+ReuseIdentifire.swift
//  Test_Weather_App
//
//  Created by Maksim Matveichuk on 11.12.22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifire: String {
        String(describing: self)
    }
}

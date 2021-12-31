//
//  Alert.swift
//  MovieApp
//
//  Created by Emre on 31.12.2021.
//

import UIKit
import EAAlert

class Alert: EAAlert {

    override var positiveButtonTextColor: UIColor {
        get {
            return appColor
        }
        set {}
    }

    override var negativeButtonTextColor: UIColor {
        get {
            return appColor
        }
        set {}
    }

    var posButtonText: String?
    override var positiveButtonText: String {
        get {
            return posButtonText ?? "Yes"
        }
        set {
            posButtonText = newValue
        }
    }

    var negButtonText: String?
    override var negativeButtonText: String {
        get {
            return negButtonText ?? "No"
        }
        set {
            negButtonText = newValue
        }
    }

}

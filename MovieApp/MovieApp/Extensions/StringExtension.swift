//
//  StringExtension.swift
//  MovieApp
//
//  Created by Emre on 1.01.2022.
//

import Foundation

extension String {

    func standardizeDates() -> String {
        return self.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
    }

}

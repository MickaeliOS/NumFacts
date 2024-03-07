//
//  StringExtension.swift
//  NumFacts
//
//  Created by Mickaël Horn on 23/01/2024.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

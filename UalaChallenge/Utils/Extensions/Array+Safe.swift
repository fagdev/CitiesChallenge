//
//  Array+Safe.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            if indices.contains(index),
               let newValue = newValue {
                self[index] = newValue
            }
        }
    }
}

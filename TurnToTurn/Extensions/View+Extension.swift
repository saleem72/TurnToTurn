//
//  View+Extension.swift
//  TurnToTurn
//
//  Created by Yousef on 5/23/22.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

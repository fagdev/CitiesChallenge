//
//  DeviceRotationModifier.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import Foundation
import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear(perform: {
                action(UIDevice.current.orientation)
            })
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

//
//  ErrorAlertModifier.swift
//  SkyGlass
//
//  Created by Mona Zarea on 13/06/2026.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var errorMessage: String?

    func body(content: Content) -> some View {
        content
            .alert(
                "SkyGlass Alert",
                isPresented: Binding(
                    get: { errorMessage != nil },
                    set: { isPresented in
                        if !isPresented { errorMessage = nil }
                    }
                ),
                presenting: errorMessage
            ) { _ in
                Button("OK", role: .cancel) {
                    errorMessage = nil
                }
            } message: { message in
                Text(message)
            }
    }
}

extension View {
    func withGenericError(errorMessage: Binding<String?>) -> some View {
        self.modifier(ErrorAlertModifier(errorMessage: errorMessage))
    }
}

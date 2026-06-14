
import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @EnvironmentObject private var themeManager: ThemeManager
    var onClear: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor( themeManager.currentTheme.primaryTextColor.opacity(0.6))
                .font(.system(size: 16, weight: .medium))

            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text("Search city or location...")
                        .foregroundColor( themeManager.currentTheme.primaryTextColor.opacity(0.4))
                }
                .foregroundColor( themeManager.currentTheme.primaryTextColor)
                .font(.body)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            if !text.isEmpty {
                Button {
                    onClear()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor( themeManager.currentTheme.primaryTextColor.opacity(0.5))
                        .font(.system(size: 16))
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .glassStyle(cornerRadius: 16,  opacity: 0.5)
        .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
    }
}

private extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: .leading) {
            if shouldShow { placeholder() }
            self
        }
    }
}

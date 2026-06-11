
import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    let theme: AppTheme
    var onClear: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(theme.primaryTextColor.opacity(0.6))
                .font(.system(size: 16, weight: .medium))

            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text("Search city or location...")
                        .foregroundColor(theme.primaryTextColor.opacity(0.4))
                }
                .foregroundColor(theme.primaryTextColor)
                .font(.body)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            if !text.isEmpty {
                Button {
                    onClear()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(theme.primaryTextColor.opacity(0.5))
                        .font(.system(size: 16))
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .glassStyle(cornerRadius: 16, theme: theme, opacity: 0.5)
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

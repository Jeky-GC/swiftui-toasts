import SwiftUI

internal struct ToastView: View {
    @ObservedObject var model: ToastModel
    @Environment(\.colorScheme) private var colorScheme

    private var isDark: Bool { colorScheme == .dark }

    var body: some View {
        ZStack() {
            main
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(Color.toastBackground)
                )
                .shadow(color: .primary.opacity(isDark ? 0.0 : 0.1), radius: 16, y: 8.0)
                .transition(
                    .modifier(
                        active: TransformModifier(yOffset: 0.0, scale: 1.0, opacity: -1.0),
                        identity: TransformModifier(yOffset: 0.0, scale: 1.0, opacity: 1.0)
                    )
                )
                .id(model.message)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }

    private var main: some View {
        HStack(spacing: 10) {
            if let icon = model.icon {
                icon
                    .frame(width: 19, height: 19)
                    .padding(.leading, 10)
            }

            Text(model.message)
                .font(.custom("Urbanist-Medium", size: UIDevice().isIpad ? 20 : 15))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .layoutPriority(1)
                .frame(alignment : .center)// Ensures the text takes priority in layout
            
            if let button = model.button {
                buttonView(button)
                    .padding(.trailing, 10)
            }
        }
        .padding(.vertical, 8)
    }

    private func buttonView(_ button: ToastButton) -> some View {
        Button {
            button.action()
        } label: {
            ZStack {
                Capsule()
                    .fill(button.color.opacity(isDark ? 0.15 : 0.07))
                Text(button.title)
                    .foregroundColor(button.color)
                    .padding(.horizontal, 9)
            }
            .frame(minWidth: 64)
            .fixedSize(horizontal: true, vertical: false)
        }
        .buttonStyle(.plain)
    }
}

@available(iOS 17.0, *)
#Preview {
    VStack {
        /*ToastView(
            model: .init(value: .init(
                icon: Image(systemName: "info.circle"),
                message: "This is a toast message with dynamic width adjustment",
                button: .init(title: "Action", color: .blue, action: {})
            ))
        )*/
        
        ToastView(
            model: .init(value: .init(
                icon: nil,
                message: "Short message",
                button: nil
            ))
        )
        
        ToastView(
            model: .init(value: .init(
                icon: nil,
                message: "A longer toast message",
                button: nil
            ))
        )
    }
    .padding(20)
}

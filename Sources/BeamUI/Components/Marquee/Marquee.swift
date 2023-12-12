import Dispatch
import SwiftUI

public struct Marquee<Content: View> : View {
    var velocity: Double = 50
    var spacing: CGFloat = 10
    @ViewBuilder var content: () -> Content
    @State private var startDate = Date()
    @State private var contentWidth: CGFloat? = nil
    @State private var containerWidth: CGFloat? = nil

    public init(velocity: Double = 50, spacing: CGFloat = 10, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.spacing = spacing
        self.velocity = velocity
    }

    public var body: some View {
        TimelineView(.animation) { context in
            HStack(spacing: spacing) {
                HStack(spacing: spacing) {
                    content()
                }
                    .measureWidth { contentWidth = $0 }

                let contentPlusSpacing = (contentWidth ?? 0) + spacing
                if contentPlusSpacing != 0 {
                    let numberOfInstances = Int(((containerWidth ?? 0) / contentPlusSpacing).rounded(.up))
                    ForEach(Array(0..<numberOfInstances), id: \.self) { _ in
                        content()
                    }
                }
            }
            .offset(x: offset(at: context.date))
            .fixedSize()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .measureWidth { containerWidth = $0 }
    }

    func offset(at time: Date) -> CGFloat {
        var result = time.timeIntervalSince(startDate) * -velocity
        if let c = contentWidth {
            result.formTruncatingRemainder(dividingBy: c + spacing)
        }
        return result
    }
}

#Preview {
    struct Model: Identifiable {
        let id: UUID = UUID()
        let name: String
        let value: Double
    }

    struct Model2: Identifiable {
        let id: UUID = UUID()
        let text: String
        let color: Color
    }

    let dataModel: [Model] = [
        .init(name: "APPL", value: 0.0058),
        .init(name: "MSFT", value: -0.0078),
        .init(name: "NFLX", value: 0.0135),
        .init(name: "META", value: -0.0224),
    ]

    let dataModel2: [Model2] = [
        .init(text: "🇬🇧 Hello", color: .purple.opacity(0.2)),
        .init(text: "🇫🇷 Bonjour", color: .blue.opacity(0.2)),
        .init(text: "🇪🇸 Hola", color: .yellow.opacity(0.2)),
        .init(text: "🇮🇹 Ciao", color: .green.opacity(0.2)),
        .init(text: "🇩🇪 Guten tag", color: .orange.opacity(0.2)),
    ]

    return VStack(spacing: 12) {
        Text(verbatim: "Marquee")
            .font(.title2.bold().monospaced())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

        VStack(spacing: 2) {
            Text(verbatim: "Simple text")
                .font(.body.bold())
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Marquee(velocity: 20, spacing: 20) {
                Text(verbatim: "This is some infinitely scrolling text")
            }
        }

        VStack(spacing: 2) {
            Text(verbatim: "Reverse direction")
                .font(.body.bold())
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Marquee(velocity: -30, spacing: 20) {
                ForEach(dataModel) { model in
                    HStack {
                        Text(verbatim: model.name)
                            .font(.body.weight(.semibold))

                        let color = model.value > 0 ? Color.green : Color.red
                        Text(model.value, format: .percent)
                            .font(.body.weight(.light))
                            .foregroundStyle(color)
                    }
                }
            }
        }

        VStack(spacing: 2) {
            Text(verbatim: "Fancy")
                .font(.body.bold())
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Marquee(velocity: 40) {
                ForEach(dataModel2) { model in
                    Text(verbatim: model.text)
                        .padding()
                        .background(model.color)
                        .clipShape(Capsule())
                }
            }
        }

        Spacer()
    }
}

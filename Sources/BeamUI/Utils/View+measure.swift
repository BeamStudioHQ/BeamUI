import SwiftUI

public extension View {
    func measureHeight(_ onChange: @escaping (CGFloat) -> ()) -> some View {
        background {
            GeometryReader { proxy in
                let height = proxy.size.height
                Color.clear
                    .onAppear {
                        DispatchQueue.main.async {
                            onChange(height)
                        }
                    }
                    .onChange(of: height) { height in
                        DispatchQueue.main.async {
                            onChange(height)
                        }
                    }
            }
        }
    }

    func measureWidth(_ onChange: @escaping (CGFloat) -> ()) -> some View {
        background {
            GeometryReader { proxy in
                let width = proxy.size.width
                Color.clear
                    .onAppear {
                        DispatchQueue.main.async {
                            onChange(width)
                        }
                    }
                    .onChange(of: width) { width in
                        DispatchQueue.main.async {
                            onChange(width)
                        }
                    }
            }
        }
    }
}

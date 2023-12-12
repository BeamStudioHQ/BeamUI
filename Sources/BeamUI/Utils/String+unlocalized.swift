public extension String {
#if DEBUG
    var unlocalized: String {
        return self
    }
#else
    @available(*, deprecated, message: "You should not use unlocalized strings in release builds")
    var unlocalized: String {
        return self
    }
#endif
}

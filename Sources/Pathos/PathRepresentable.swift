public protocol PathRepresentable {
    var pathString: String { get }
    init(string: String)
}

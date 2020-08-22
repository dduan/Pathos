// compile time test that ensures `PurePathRepresentable` and related conformances is built in debug
// builds. The conformances ensure consistent interfaces between different conformers.

@testable import Pathos
func __verifyPurePathRepresentableIsCompiled() {
    _ = PurePathRepresentable.self
}

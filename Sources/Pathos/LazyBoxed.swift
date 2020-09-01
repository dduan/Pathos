@propertyWrapper
struct LazyBoxed<Value> {
    let build: () -> Value
    private let storage = Box<Optional<Value>>(nil)

    init(build: @escaping () -> Value) {
        self.build = build
    }

    var wrappedValue: Value {
        if let cachedValue = storage.content {
            return cachedValue
        }

        let value = build()
        storage.content = value
        return value
    }
}

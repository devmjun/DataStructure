import Foundation

public func example(of: String, action: () -> () ) {
    print("----------\(of)----------")
    action()
}

import Foundation

extension Double {
    var toCurrency: String {
        self.formatted(
            .currency(code: "BRL")
            .locale(Locale(identifier: "pt_BR"))
        )
    }
}

import SwiftUI

extension Color {
    static func from(name: String) -> Color {
        switch name.lowercased() {
        case "preto", "black": return .black
        case "branco", "white": return .white
        case "bege", "beige", "off-white": return Color(red: 0.96, green: 0.96, blue: 0.86)
        case "vermelho", "red": return .red
        case "azul", "blue", "marinho": return .blue
        case "verde", "green": return .green
        case "cinza", "gray": return .gray
        case "marrom", "brown": return .brown
        case "rosa", "pink": return .pink
        case "amarelo", "yellow", "dourado", "gold": return .yellow
        default: return .clear
        }
    }
}

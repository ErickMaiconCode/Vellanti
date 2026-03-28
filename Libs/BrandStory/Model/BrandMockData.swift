import Foundation

struct BrandMockData {
    static let story = BrandStory (
        firstImage: "Vellanti_Commerce",
        title: "Vellanti",
        subtitle: "O luxo é percebido... ou sentido?",
        firstSection: ShowSection(
            title: "A ORIGEM",
            body: "Vellanti nasce de uma inquietação silenciosa, a busca por um luxo que não precisa ser anunciado.\nEm um mundo saturado de excessos, escolhe o caminho oposto: o da presença sutil, da estética que se revela aos poucos. Aqui, o essencial não é exibido, é descoberto."
        ),
        middleImage: "Vellanti_Bag",
        middleSection: ShowSection (
            title: "A ESSÊNCIA",
            body: "Mais do que forma, Vellanti é sensação.\nCada textura, cada contraste e cada espaço são pensados para criar uma experiência que antece a lógica.\nInspirada pela precisão da tecnologia e pela intuição da arte, a marca existe no equilíbrio entre o que é construído e o que é sentido."
        ),
        footerImage: "Vellanti_BrandLogo"
    )
}

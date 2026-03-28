import Foundation

struct RunwayMockData {
    
    static let feedShows: [RunwayShow] =  [
        RunwayShow(
        title: "VALENTINO FALL 2026",
        subtitle: "Interferência entre tradição e ruptura",
        homeCoverImage: "Valentino_Home",
        homeVideoName: nil,
        detailVideoName: "Valentino_Show",
        detailImageName: nil,
        
        introSection: ShowSection (
            title: "ESSÊNCIA",
            body: "Em Roma, a Valentino revisita seu legado sob Alessandro Michele. O vermelho icônico como ruptura e reverência."
        ),
        middleImage: "Valentino_Middle",
        
        conceptSection: ShowSection (
            title: "CONSTRUÇÃO",
            body: "Ombros marcantes, cortes profundos e volumes dramáticos criam tensão entre estrutura e fluidez."
        ),
        detailImage: "Valentino_Footer",
        
        footerSection: ShowSection(
            title: "EXPRESSÃO",
            body: "Uma coleção que desafia o clássico para redefinir o luxo contemporâneo."
        ),
        
        actions: [
            ShowAction(title: "Ver Desfile", url: "https://www.youtube.com/live/2pp0L-mFjMs?si=vN4rnEOl-_qfPEHy"),
            ShowAction(title: "Ver LookBook", url: "https://wwd.com/fashion-news/shows-reviews/gallery/valentino-fall-2026-ready-to-wear-collection-1238673424/")
        ]
    ),
        RunwayShow(
            title: "Gucci Runway Debut by Demna",
            subtitle: "O novo estado de espírito do luxo",
            homeCoverImage: "Gucci_Home",
            homeVideoName: nil,
            detailVideoName: "Gucci_Runway",
            detailImageName: nil,
            
            introSection: ShowSection (
                title: "CONTEXTO",
                body: "Em sua estréia na Gucci, Demna reposiciona a marca como parte viva da cultura contemporânea."
            ),
            middleImage: "Gucci_Middle",
            
            conceptSection: ShowSection (
                title: "ESTÉTICA",
                body: "Silhuetas ajustadas, atitude urbana e referências dos anos 2000 traduzem um luxo mais direto, jovem e provocador."
            ),
            detailImage: "Gucci_Footer",
            
            footerSection: ShowSection(
                title: "EXPRESSÃO",
                body: "Mais do que vestir, a coleção propõe um estado de espírito: sentir, viver e ser Gucci."
            ),
            
            actions: [
                ShowAction(title: "Ver Desfile", url: "https://www.youtube.com/live/tOi6Wz9Kucw?si=z3aSjJuu14D6zYgn"),
                ShowAction(title: "Ver LookBook", url: "https://www.gucci.com/int/en/nst/pre-fall-2026-lookbook?srsltid=AfmBOoqcRTB-8hX2l7zEWrhOXiLUp3YaY3js-yEZdUknxkNDHXnJZT10")
            ]
        ),
        
        RunwayShow(
            title: "Louis Vuitton Menswear 2026",
            subtitle: "Clássico reinventado pelo futuro",
            homeCoverImage: "Louis_Vuitton_Home",
            homeVideoName: nil,
            detailVideoName: "Louis_Vuitton_Men",
            detailImageName: nil,
            
            introSection: ShowSection (
                title: "CONCEITO",
                body: "Na Louis Vuitton, Pharrel Williams redefine o luxo como precisão, funcionalidade e inovação."
            ),
            middleImage: "Louis_Vuitton_Middle",
            
            conceptSection: ShowSection (
                title: "CONSTRUÇÃO",
                body: "Alfaiataria clássica encontra materiais tecnológicos, criando peças elegantes que também performam."
            ),
            detailImage: "Louis_Vuitton_Footer",
            
            footerSection: ShowSection(
                title: "VISÃO",
                body: "Um novo luxo: sofisticado, funcional e pensado para o cotidiado contemporâneo."
            ),
            
            actions: [
                ShowAction(title: "Ver Desfile", url: "https://www.youtube.com/live/3VSghNTL_pY?si=ukJH3dw11me-Q7vX"),
                ShowAction(title: "Ver LookBook", url: "https://eu.louisvuitton.com/eng-e1/magazine/articles/men-fall-winter-2026-show")
            ]
        ),
        
        RunwayShow(
            title: "Chanel Haute Couture",
            subtitle: "Poética do cotidiano elevado",
            homeCoverImage: "Chanel_Home",
            homeVideoName: nil,
            detailVideoName: "Chanel_Haute_Couture",
            detailImageName: nil,
            
            introSection: ShowSection (
                title: "CONCEITO",
                body: "Na Chanel, Matthieu Blazy reimagina a alta-costura como algo próximo, leve e vivido no dia a dia."
            ),
            middleImage: "Chanel_Middle",
            
            conceptSection: ShowSection (
                title: "DETALHES",
                body: "Bordados delicados, transparência e elementos naturais criam uma estética etérea e extremamente refinada."
            ),
            detailImage: "Chanel_Footer",
            
            footerSection: ShowSection(
                title: "SENSAÇÃO",
                body: "Uma coleção que transforma o luxo em poesia - suave, íntimo e atemporal."
            ),
            
            actions: [
                ShowAction(title: "Ver Desfile", url: "https://www.youtube.com/live/M5QhKDc5V4Y?si=SW6IZCcu2Z4A7HvX"),
                ShowAction(title: "Ver LookBook", url: "https://www.chanel.com/br/alta-costura/primavera-verao-2026/")
            ]
        ),
        
        RunwayShow(
            title: "Dolce & Gabbana IDENTITY",
            subtitle: "A força de uma identidade inabalável",
            homeCoverImage: "Dolce_&_Gabanna_Home",
            homeVideoName: nil,
            detailVideoName: "Dolce_&_Gabbana",
            detailImageName: nil,
            
            introSection: ShowSection (
                title: "LEGADO",
                body: "A Dolce & Gabbana reafirma sua essência após quatro décadas, celebranco uma identidade que resiste ao tempo."
            ),
            middleImage: "Doce_&_Gabanna_Middle",
            
            conceptSection: ShowSection (
                title: "DETALHES",
                body: "Alfaiataria precisa, silhietas marcantes e o preto absoluto definem uma estética fiel às suas origens."
            ),
            detailImage: "Dolce_&_Gabanna_Footer",
            
            footerSection: ShowSection(
                title: "ESSÊNCIA",
                body: "Em meio à mudança da moda, permanecer autêntico se torna o verdadeiro luxo."
            ),
            
            actions: [
                ShowAction(title: "Ver Desfile", url: "https://www.youtube.com/live/Mp7y7Jn3UP0?si=f4b6sDe2Nhe92b9O"),
                ShowAction(title: "Ver LookBook", url: "https://world.dolcegabbana.com/fashion-shows/women-fall-winter-2026-fashion-show?_gl=1*1rlqnn3*_up*MQ..*_gs*MQ..*_gcl_aw*R0NMLjE3NzQ1NTY1MzkuQ2p3S0NBandzcFBPQmhCOUVpd0FURmJpNUxHazE2Z2tlS3BLTzdHRU11T2VyUFJEZm1vczRyT0oyNGFDOWdzS2xOOXRqZTF6Z3ZnbExob0NGeWdRQXZEX0J3RQ..*_gcl_au*MjA4MDc3NzAzLjE3NzQ1NTY1MTg.*FPAU*MjA4MDc3NzAzLjE3NzQ1NTY1MTg.*_ga*Njc1NTYwMjI5LjE3NzQ1NTY1MTc.*_ga_2S6SQZ66CV*czE3NzQ1NTY1MTckbzEkZzEkdDE3NzQ1NTY1NDIkajM3JGwwJGgyMTMyNjgwNTAz*_fplc*YzFhYUhyb0hKeUZoZE9kRHNWbEdFaWhvOUM5dTQxJTJCMlR3N3dUbnRFOWVPUHI1b0cyeEZ0a280d1JjJTJCTjI4QWZqJTJCUm0wa09meURZbksyR1pkYzZjQzNVVnRSaGlqSnZJWmtXODJSSzFrRDBHdUlhTDNJNjRuYm1pMzd0QUFBJTNEJTNE&gclid=CjwKCAjwspPOBhB9EiwATFbi5LGk16gkeKpKO7GEMuOerPRDfmos4rOJ24aC9gsKlN9tje1zgvglLhoCFygQAvD_BwE&gbraid=0AAAABAbhoO1qcvEzuKFUmMQQTLfDGg4Ct")
            ]
        ),
    ]
}

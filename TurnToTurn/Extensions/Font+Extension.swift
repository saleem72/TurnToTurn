//
//  Font+Extension.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/20/21.
//

import SwiftUI

enum FontType: String, Identifiable, CaseIterable {
    case largeTitle
    case title
    case title2
    case title3
    case body
    case headline
    case callout
    case subheadline
    case footnote
    case caption
    case caption2
    
    var id: String { rawValue }
    
    var textStyle: Font.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .footnote: return .footnote
        case .caption: return .caption
        case .caption2: return .caption2
        case .callout: return .callout
        }
    }
    
    var size: CGFloat {
        switch self {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17 // semiBold
        case .subheadline: return 15
        case .body: return 17
        case .footnote: return 13
        case .caption: return 12
        case .caption2: return 11
        case .callout: return 16
        }
    }
    
    var fontName: String {
        switch self {
        case .largeTitle, .title, .title2, .title3: return "SFProText-Bold"
        case .body, .subheadline, .footnote, .caption, .callout: return "SFProText-Regular"
        case .headline, .caption2: return "SFProText-SemiBold"
        }
    }
}

extension Font {
    static var gallery = FontsBook()
}


struct FontsBook {
    func regular(_ size: CGFloat = 16) -> Font {
        Font.custom("SFProText-Regular", size: size)
    }
    
    func semiBold(_ size: CGFloat = 16) -> Font {
        Font.custom("SFProText-SemiBold", size: size)
    }
    
    func bold(_ size: CGFloat = 16) -> Font {
        Font.custom("SFProText-Bold", size: size)
    }
    
    func light(_ size: CGFloat = 16) -> Font {
        Font.custom("SFProText-Light", size: size)
    }

    func medium(_ size: CGFloat = 16) -> Font {
        Font.custom("SFProText-Medium", size: size)
    }

    func heavy(_ size: CGFloat = 16) -> Font {
        Font.custom("SFProText-Heavy", size: size)
    }
    
    func dynamic(_ type: FontType) -> Font {
        return Font.custom(type.fontName, size: type.size, relativeTo: type.textStyle)
    }
    
    var largeTitle: Font {
        dynamic(.largeTitle)
    }
    var title: Font {
        dynamic(.title)
    }
    var title2: Font {
        dynamic(.title2)
    }
    var title3: Font {
        dynamic(.title3)
    }
    var body: Font {
        dynamic(.body)
    }
    var headline: Font {
        dynamic(.headline)
    }
    var callout: Font {
        dynamic(.callout)
    }
    var subheadline: Font {
        dynamic(.subheadline)
    }
    var footnote: Font {
        dynamic(.footnote)
    }
    var caption: Font {
        dynamic(.caption)
    }
    var caption2: Font {
        dynamic(.caption2)
    }
    
}

struct CustomFontModifire: ViewModifier {
    
    var type: FontType
    
    func body(content: Content) -> some View {
        content
            .font(Font.gallery.dynamic(type))
    }
}

extension View {
    func customFont(type: FontType = .body) -> some View {
        modifier(CustomFontModifire(type: type))
    }
}

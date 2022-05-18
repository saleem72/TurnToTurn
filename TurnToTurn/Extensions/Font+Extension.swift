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
    
    var font: Font {
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
    
    
}

extension Font {
    
    static var gallery = FontsBook()
    
    static func appRegular(size: CGFloat) -> Font {
        Font.custom("Cairo-Regular", size: size)
    }
    
    static func appSemiBold(size: CGFloat) -> Font {
        Font.custom("Cairo-SemiBold", size: size)
    }
    
    static func appBold(size: CGFloat) -> Font {
        Font.custom("Cairo-Bold", size: size)
    }
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
        switch type {
        case .headline:
            return Font.custom("Cairo-SemiBold", size: type.size, relativeTo: type.textStyle).bold()
        default:
            return Font.custom("Cairo-Regular", size: type.size, relativeTo: type.textStyle)
        }
    }
    
    func largeTitle() -> Font {
        dynamic(.largeTitle)
    }
    func title() -> Font {
        dynamic(.title)
    }
    func title2() -> Font {
        dynamic(.title2)
    }
    func title3() -> Font {
        dynamic(.title3)
    }
    func body() -> Font {
        dynamic(.body)
    }
    func headline() -> Font {
        dynamic(.headline)
    }
    func callout() -> Font {
        dynamic(.callout)
    }
    func subheadline() -> Font {
        dynamic(.subheadline)
    }
    func footnote() -> Font {
        dynamic(.footnote)
    }
    func caption() -> Font {
        dynamic(.caption)
    }
    func caption2() -> Font {
        dynamic(.caption2)
    }
    
}



//MARK: - Important ViewModifire to make font scale

// MARK: Important Note
/*
 SwiftUI comes with support for all of Dynamic Type’s font sizes, all set using the .font() modifier. However, if you ask for a specific font and size, you’ll find your text no longer scales up or down automatically according to the user’s Dynamic Type settings – it remains fixed.

 To work around this we need to create a custom ViewModifier that can scale up our font size based on the current accessibility setting, and also detect when that setting changes.
 */

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct MyScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var textStyle: FontType
    var fontWieght: Font.Weight
    
    var name: String {
        switch fontWieght {
        case .bold: return "Cairo-Bold"
        case .semibold: return "Cairo-SemiBold"
        default: return "Cairo-Regular"
        }
    }
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: textStyle.size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func myScaledFont(textStyle: FontType = .body, fontWieght: Font.Weight = .regular) -> some View {
        return self.modifier(MyScaledFont(textStyle: textStyle, fontWieght: fontWieght))
    }
}

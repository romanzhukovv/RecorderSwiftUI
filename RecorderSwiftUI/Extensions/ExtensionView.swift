//
//  ExtensionView.swift
//  AudioRedSU
//
//  Created by Dmitrii Onegin on 15.03.2022.
//

import SwiftUI

struct OnTap: ViewModifier {
    let response: (CGPoint) -> Void
    
    @State private var location: CGPoint = .zero
    func body(content: Content) -> some View {
        content
            .onTapGesture(count: 2) {
                response(location)
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { location = $0.location }
            )
    }
}

extension View {
    func onTapGesture(_ handler: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(OnTap(response: handler))
    }
}

extension Color {
    
    static let customRed = Color(#colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1))
    static let sh_basicRed = Color(#colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1))
    
    static let sh_darkRed = Color(#colorLiteral(red: 0.7529411765, green: 0.1098039216, blue: 0.09411764706, alpha: 1))
    static let sh_lightRed = Color(#colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3137254902, alpha: 1))
    
    static let customGray = Color(#colorLiteral(red: 0.3137254902, green: 0.3333333333, blue: 0.3607843137, alpha: 1))
    static let sh_basicGrey = Color(#colorLiteral(red: 0.3137254902, green: 0.3333333333, blue: 0.3607843137, alpha: 1))
    
    static let sh_darkGrey = Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1))
    
    static let customLightGray = Color(#colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1))
    static let sh_Grey = Color(#colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1))
    
    static let sh_lightGrey = Color(#colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1))
    
    static let sh_colorFrame = Color(#colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 0.4492752378))
    

        }

let WIDTH = UIScreen.main.bounds.width
let HEIGHT = UIScreen.main.bounds.height

let fontBold28 = Font.system(size: 28, weight: .bold)
let fontBold24 = Font.system(size: 24, weight: .bold)
let fontBold16 = Font.system(size: 16, weight: .bold)
let fontBold12 = Font.system(size: 12, weight: .bold)
let fontMedium16 = Font.system(size: 16, weight: .medium)
let fontMedium12 = Font.system(size: 12, weight: .medium)
let fontMedium10 = Font.system(size: 10, weight: .medium)
let fontRegular12 = Font.system(size: 12, weight: .regular)
let fontRegular9 = Font.system(size: 9, weight: .regular)
let fontLight16 = Font.system(size: 16, weight: .light)
let fontLight12 = Font.system(size: 12, weight: .light)

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners: UIRectCorner = .allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}




//
//  ThemesAndColors.swift
//  Navigation
//
//  Created by v.milchakova on 27.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct Theme {
    enum ThemeName {
        case light
        case dark
    }
    let type: ThemeName
    let colors: ColorPalette
    let labelColor = (light: UIColor.black, dark: UIColor.white)
}

enum ColorPalette {
    case light
    case dark
}

extension Theme {
    static let light = Theme(type: .light, colors: .light)
    static let dark = Theme(type: .dark, colors: .dark)
}

protocol Themeable: class {
    func changeTheme(_ theme: UIUserInterfaceStyle)
}

func systemLabelColor(collection: UITraitCollection) -> UIColor {
    switch collection.userInterfaceStyle {
    case .dark:
        return UIColor.white
    case .light:
        return UIColor.black
    default:
        return UIColor.black
    }
}

func systemViewColor(_ collection: UITraitCollection) -> UIColor {
    switch collection.userInterfaceStyle {
    case .dark:
        return UIColor.black
    case .light:
        return UIColor.white
    default:
        return UIColor.white
    }
}

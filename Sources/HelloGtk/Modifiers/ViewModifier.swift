//
//  ViewModifier.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

import CGtk
import Gdk
import Gtk
import TokamakCore

protocol WidgetViewModifier {
    func create() -> Widget
    func update(_ widget: Widget) -> Void
}

extension AnyColorBox.ResolvedValue {
    var rgba: RGBA {
        var gdkRGBA = GdkRGBA(red: red, green: green, blue: blue, alpha: opacity)
        let color = withUnsafePointer(to: &gdkRGBA, RGBA.init)
        return color
    }
}

extension _BackgroundModifier: WidgetViewModifier where Background == Color {
    func create() -> Widget {
        let box = Box(orientation: .horizontal, spacing: 0)
        update(box)
        return box
    }

    func update(_ widget: Widget) -> Void {
        guard let box = widget as? Box else { return }
        let resolved = _ColorProxy(self.background).resolve(in: environment)
        box.overrideBackgroundColor(state: .normal, color: resolved.rgba)
    }
}

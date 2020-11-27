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

extension _BackgroundModifier: WidgetViewModifier where Background == Color {
    func create() -> Widget {
        let box = Box(orientation: .horizontal, spacing: 0)
        update(box)
        return box
    }

    func update(_ widget: Widget) -> Void {
        guard let box = widget as? Box else { return }
        let resolved = _ColorProxy(self.background).resolve(in: environment)
        var gdkRGBA = GdkRGBA(red: resolved.red, green: resolved.green, blue: resolved.blue, alpha: resolved.opacity)
        withUnsafePointer(to: &gdkRGBA) { color in
            let rgba = RGBA(color)
            box.overrideBackgroundColor(state: .normal, color: rgba)
        }
    }
}

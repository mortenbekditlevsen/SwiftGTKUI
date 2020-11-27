//
//  VStack.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

import CGtk
import Gtk
import TokamakCore

extension HorizontalAlignment {
    var gtkAlign: GtkAlign {
        switch self {
        case .center:
            return .center
        case .leading:
            return .start
        case .trailing:
            return .end
        }
    }
}

extension VStack: ViewDeferredToRenderer {
    public var deferredBody: AnyView {
        let spacing = self.spacing.map(Int.init) ?? 10
        let alignment = self.alignment.gtkAlign
        let w = ParentWidget(
            create: {
                let box = Box(orientation: .vertical, spacing: spacing)
                box.setHalign(align: alignment)
                return box
            },
            update: { widget in
                guard let box = widget as? Box else { return }
                box.setHalign(align: alignment)
                box.spacing = spacing
            },
            children: children
        )
        return AnyView(w)
    }
}

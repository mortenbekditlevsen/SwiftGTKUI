//
//  HStack.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

import Gtk
import CGtk
import TokamakCore

extension VerticalAlignment {
    var gtkAlign: GtkAlign {
        switch self {
        case .center:
            return .center
        case .top:
            return .start
        case .bottom:
            return .end
        }
    }
}

extension HStack: ViewDeferredToRenderer {
    public var deferredBody: AnyView {
        let spacing = self.spacing.map(Int.init) ?? 10
        let alignment = self.alignment.gtkAlign
        let w = ParentWidget(
            create: {
                let box = Box(orientation: .horizontal, spacing: spacing)
                box.setValign(align: alignment)
                return box
            },
            update: { widget in
                guard let box = widget as? Box else { return }
                box.setValign(align: alignment)
                box.spacing = spacing
            },
            children: children
        )

        return AnyView(w)
    }
}

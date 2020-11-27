//
//  Button.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

import Gtk
import TokamakCore

extension Button: ViewDeferredToRenderer {
    public var deferredBody: AnyView {
        let implementation = body as! _Button<Label>
        let w = ParentWidget(
            create: {
                let button = Gtk.Button()
                button.connect(signal: .clicked, to: { implementation.action() })
                return button
            },
            update: { _ in },
            children: children
        )

        return AnyView(w)
    }
}

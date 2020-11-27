//
//  Text.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

import Gtk
import TokamakCore

extension Text: ViewDeferredToRenderer {
    public var deferredBody: AnyView {
        let proxy = _TextProxy(self)
//        var weight: Font.Weight?
//        for modifier in proxy.modifiers {
//            switch modifier {
//            case .weight(let theWeight):
//                weight = theWeight
//            default:
//                ()
//            }
//        }
        let w = SingleWidget(
            create: {
                Label(str: proxy.rawText)
            },
            update: { widget in
                guard let label = widget as? Label else { return }
                label.text = proxy.rawText
            }
        )
        return AnyView(w)
  }
}

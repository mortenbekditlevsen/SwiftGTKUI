//
//  Widget.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

import Gtk
import TokamakCore

protocol AnyWidget {
    var create: () -> Widget { get }
    var update: (Widget) -> Void { get }
}

struct SingleWidget: View, AnyWidget {
    public typealias Body = Never
    var create: () -> Widget
    var update: (Widget) -> Void
    var body: Never {
        neverBody("SingleWidget")
    }
}

struct ParentWidget: View, AnyWidget, ParentView {
    public typealias Body = Never
    var create: () -> Widget
    var update: (Widget) -> Void
    var body: Never {
        neverBody("ParentWidget")
    }
    var children: [AnyView]
}

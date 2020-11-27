//
//  WidgetRenderer.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

import Gtk
// TODO: ifdef and replace by something else on linux
import Dispatch
import TokamakCore

// TODO: This is probably not the correct way to hold on to widgets in GTK
// but I don't know any better, and it appears that they are not being retained
// by being mounted in the UI hierarchy
var widgets: [Widget] = []

public final class WidgetTarget: Target {
    public var view: AnyView

    var widget: Widget
    var children: [WidgetTarget] = []

    init<V: View>(_ view: V,
                  _ widget: Widget) {
        self.widget = widget
        self.view = AnyView(view)
    }
}

public final class WidgetRenderer: Renderer {
    public typealias TargetType = WidgetTarget

    private let application: ApplicationRef

    public private(set) var reconciler: StackReconciler<WidgetRenderer>?
    var rootTarget: WidgetTarget

    // TODO: Allow definition of 'app' or 'scenes' to abstract window creation
    public var applicationWindow: ApplicationWindowRef {
        let window = ApplicationWindowRef(application: application)
        window.title = "Hello, world"
        window.setDefaultSize(width: 320, height: 240)
        window.add(widget: rootTarget.widget)
        widgets.append(rootTarget.widget)
        return window
    }

    public init<V: View>(_ view: V, application: ApplicationRef) {
        self.application = application
        let box = Box(orientation: .vertical, spacing: 10)
        box.setHalign(align: .center)
        box.setValign(align: .center)
        rootTarget = WidgetTarget(view, box)
        reconciler = StackReconciler(
            view: view,
            target: rootTarget,
            environment: EnvironmentValues(),
            renderer: self
        ) { closure in
            // TODO: ifdef and replace by something else on linux
            DispatchQueue.main.async { closure() }
        }
    }

    public func mountTarget(before sibling: WidgetTarget?, to parent: WidgetTarget, with host: MountedHost) -> WidgetTarget? {
        guard let widget: Widget = mapAnyView(host.view, transform: { (v: AnyWidget) in
            v.create()
        }) else {
            if mapAnyView(host.view, transform: { (view: ParentView) in view }) != nil {
              return parent
            }

            return nil
        }
        let node = WidgetTarget(host.view, widget)
        widgets.append(widget)
        if let container = parent.widget as? Container {
            container.add(widget: widget)
        }
        parent.children.append(node)
        return node
    }

    public func update(target: WidgetTarget, with host: MountedHost) {
        guard let v = mapAnyView(host.view, transform: { (v: AnyWidget) in v })
        else { return }

        v.update(target.widget)
    }

    public func unmount(target: WidgetTarget, from parent: WidgetTarget, with host: MountedHost, completion: @escaping () -> ()) {
        guard let container = parent.widget as? Container else { return }
        container.remove(widget: target.widget)
        widgets.removeAll(where: { target.widget === $0 })
    }
}

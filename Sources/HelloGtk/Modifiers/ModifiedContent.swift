//
//  ModifiedContent.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

import TokamakCore

private protocol AnyModifiedContent {
  var anyContent: AnyView { get }
  var anyModifier: WidgetViewModifier { get }
}

extension ModifiedContent: AnyModifiedContent where Modifier: WidgetViewModifier, Content: View {
  var anyContent: AnyView {
    AnyView(content)
  }

  var anyModifier: WidgetViewModifier {
    modifier
  }
}

extension ModifiedContent: ViewDeferredToRenderer where Content: View {
    public var deferredBody: AnyView {
        guard let widgetModifier = modifier as? WidgetViewModifier else {
            return AnyView(content)
        }
        let w = ParentWidget(
            create: widgetModifier.create,
            update: widgetModifier.update,
            children: [AnyView(content)]
        )
        return AnyView(w)
    }
}

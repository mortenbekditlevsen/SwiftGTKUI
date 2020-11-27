import Gtk

// TODO: The renderer needs to be kept alive in order for the update loop
// to work. There's probably a better way to do this.
var renderer: WidgetRenderer?

let status = Application.run(startupHandler: nil) { app in
    renderer = WidgetRenderer(ContentView(), application: app)
    let window = renderer?.applicationWindow
    window?.showAll()
}

guard let status = status else {
    fatalError("Could not create Application")
}
guard status == 0 else {
    fatalError("Application exited with status \(status)")
}

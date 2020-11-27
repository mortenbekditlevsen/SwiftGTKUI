//
//  ContentView.swift
//  HelloGtk
//
//  Created by Morten Bek Ditlevsen on 27/11/2020.
//

struct ContentView : View {
    @State var spacing: CGFloat = 10
    @State var alignment: VerticalAlignment = .top
    var body: some View {
        Text("Hello, world!")
        Text("Hello, world 2! \(spacing)")
        Text("Hello, world 3!")
        HStack(alignment: alignment, spacing: spacing) {
            VStack(spacing: spacing) {
                Button("Increase spacing") {
                    spacing += 10
                }
                Button("Decrease spacing") {
                    spacing -= 10
                }
            }
            Text("Hello, world 6!").background(Color(red: 0.5, green: 0.3, blue: 0.6, opacity: 1))
            VStack(spacing: spacing) {
                Text("Hello, world 7!")
                Text("Hello, world 8!")
            }
        }
        //    Text("Hello, world 7!")
        Button("Change alignment") {
            if alignment == .top {
                alignment = .bottom
            } else {
                alignment = .top
            }
        }
        Button {
            print("Tapped!")
        } label: {
            VStack {
                Text("Big")
                Text("Button")
            }
        }
    }
}

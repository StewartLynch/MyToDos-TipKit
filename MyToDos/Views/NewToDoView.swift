//
// Created for MyToDos
// by  Stewart Lynch on 2023-08-28
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI

struct NewToDoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var newToDoText: String = ""
    @Bindable var dataStore: DataStore
    let createToDoTip: CreateToDoTip
    let swipeActionTip: SwipeActionTip
    var body: some View {
        NavigationStack {
            VStack {
                Text("Add a New ToDo to your list").font(.headline)
                TextField("New ToDo", text: $newToDoText)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Spacer()
                    Button("Create") {
                        if !newToDoText.isEmpty {
                            let newToDo = ToDo(name: newToDoText)
                            dataStore.addToDo(newToDo)
                            createToDoTip.invalidate(reason: .actionPerformed)
                            newToDoText = ""
                            Task {
                                await SwipeActionTip.swipeActionEvent.donate()
                            }
                        }
                        dismiss()
                    }.disabled(newToDoText.isEmpty)
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .navigationTitle("New ToDo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    NewToDoView(
        dataStore: DataStore(),
        createToDoTip: CreateToDoTip(),
        swipeActionTip: SwipeActionTip()
    )
}

//
// Created for MyToDos
// by  Stewart Lynch
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI
import TipKit

struct ToDoListView: View {
    @Environment(DataStore.self) var dataStore
    @Environment(\.openURL) private var openURL
    @State private var newToDoText = ""
    @State private var newToDoAlert = false
    @FocusState var focusedField: Bool?
    let createToDoTip = CreateToDoTip()
    let swipeActionTip = SwipeActionTip()
    let completionToDeleteTip = CompletionToDeleteTip()
    let filterTip = FilterTip()
    var body: some View {
        @Bindable var dataStore = dataStore
        NavigationStack {
            Group {
                if !dataStore.filteredToDos.isEmpty {
                    TipView(completionToDeleteTip, arrowEdge: .bottom)
                        .tipBackground(.red.opacity(0.2))
                        .tint(.red)
                        .padding()
                    TipView(filterTip, arrowEdge: .bottom) { action in
                        if action.id == "learn-more" {
                            openURL(URL(string: "https://www.createchsol.com/tutorials")!)
                        }
                    }
                    List() {
                        TipView(swipeActionTip)
                        ForEach($dataStore.filteredToDos) { $toDo in
                            TextField(toDo.name, text: $toDo.name)
                                .font(.title3)
                                .foregroundStyle(toDo.completed ? .green : Color(.label))
                                .focused($focusedField, equals: true)
                                .overlay {
                                    Rectangle()
                                        .fill(Color.green)
                                        .frame(height: 1)
                                        .opacity(toDo.completed ? 1 : 0)
                                }
                                .onSubmit {
                                    dataStore.updateToDo(toDo)
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            dataStore.deleteToDo(toDo)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        toDo.completed.toggle()
                                        dataStore.updateToDo(toDo)
                                        if dataStore.completeedToDosCount >= 3 {
                                            CompletionToDeleteTip.reachedThresholdParameter = true
                                        }
                                    } label: {
                                        Text(toDo.completed ? "Remove Completion" : "Completed")
                                    }.tint(.teal)
                                }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .onChange(of: dataStore.completeedToDosCount) { oldValue, newValue in
                        if oldValue >= 3 && newValue < 3 {
                            completionToDeleteTip.invalidate(reason: .actionPerformed)
                        }
                    }
                } else {
                    if dataStore.toDos.isEmpty {
                        ContentUnavailableView {
                            Label("You have no ToDos", image: "No ToDos")
                        } description: {
                            Text("Start creating your own list of ToDos").font(.largeTitle)
                        }
                    } else {
                        ContentUnavailableView.search
                    }
                }
            }
            .task {
                await FilterTip.showFilterTipEvent.donate()
            }
            .navigationTitle("My ToDos")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        focusedField = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
                ToolbarItem {
                    Button {
                        newToDoAlert.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .popoverTip(createToDoTip, arrowEdge: .top)
                }
            }
        }
        .sheet(isPresented: $newToDoAlert) {
            NewToDoView(dataStore: dataStore, createToDoTip: createToDoTip, swipeActionTip: swipeActionTip)
                .presentationDetents([.medium])
        }
        .alert("File Error",
               isPresented: $dataStore.showErrorAlert,
               presenting: dataStore.appError) { appError in
            appError.button
        } message: { appError in
            Text(appError.message)
        }
        .showSearchBar(showSearch: !dataStore.toDos.isEmpty, filterText: $dataStore.filterText)
    }
}
struct ShowSearchBar: ViewModifier {
    let showSearch: Bool
    @Binding var filterText: String
    func body(content: Content) -> some View {
        if showSearch {
            content
                .searchable(text: $filterText, prompt: Text("Filter ToDos"))
        } else {
            content
        }
    }
}

extension View {
    func showSearchBar(showSearch: Bool, filterText: Binding<String>) -> some View {
        modifier(ShowSearchBar(showSearch: showSearch, filterText: filterText))
    }
}

#Preview("ToDoListView") {
    ToDoListView()
        .onAppear {
            print(URL.documentsDirectory.path(percentEncoded: false))
        }
        .environment(DataStore())
}

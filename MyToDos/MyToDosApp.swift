//
// Created for MyToDos
// by  Stewart Lynch
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

import OSLog
import SwiftUI
import TipKit

@main
struct MyToDosApp: App {
    @State private var dataStore = DataStore()
    var body: some Scene {
        let logger = Logger()
        WindowGroup {
            ToDoListView()
                .onAppear {
                    logger.info("\(URL.documentsDirectory.path())")
                }
                .environment(dataStore)
        }
    }
    init() {
        // Purge all TipKit related data.
//        try? Tips.resetDatastore()
        
        // Show some tips but not all
//        Tips.showTipsForTesting([CompletionToDeleteTip.self])
        
        // Hide some tips but not all
//        Tips.hideTipsForTesting([CreateToDoTip.self])
        
        // Show all defined tips in the app.
//        Tips.showAllTipsForTesting()
        
        // Hide all tips define in the app
//        Tips.hideAllTipsForTesting()
        
        try? Tips.configure([
            .datastoreLocation(.applicationDefault),
            .displayFrequency(.immediate)
        
        ])
    }

}

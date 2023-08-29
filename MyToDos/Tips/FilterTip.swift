//
// Created for MyToDos
// by  Stewart Lynch on 2023-08-29
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import Foundation
import TipKit

struct FilterTip: Tip {
    
    static let showFilterTipEvent = Event(id: "showFilterTipEvent")
    var title: Text {
        Text("Search and filter with tags.")
    }
    
    var message: Text? {
        Text("Start your ToDos with a word surrounded by brackets like [Work] so you can effectively filter your ToDo list.")
    }
    
    var image: Image? {
        Image(systemName: "tag.fill")
    }
    
    var actions: [Action] {
        [
        Action(id: "learn-more", title: "Learn More")
        ]
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.showFilterTipEvent) {
                $0.donations.count >= 4
            }
        ]
    }
}

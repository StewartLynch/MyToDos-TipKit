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

struct SwipeActionTip: Tip {
    static let swipeActionEvent = Event(id: "swipeActionEvent")
    
    var options: [TipOption] {
        [
            Tips.MaxDisplayCount(1),
            Tips.IgnoresDisplayFrequency(true)
        
        ]
    }
    
    var title: Text {
        Text("Swipe Actions")
    }
    
    var message: Text? {
        Text("Swipe from leading edge to mark as completed\nSwipe from trailing edge to delete.")
    }
    
    var image: Image? {
        Image(.noToDos)
    }
    
    var rules: [Rule] {
        [
        
            #Rule(Self.swipeActionEvent) { event in
                event.donations.count >= 3
            }
        ]
    }
    
}

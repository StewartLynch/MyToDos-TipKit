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

struct CompletionToDeleteTip: Tip {
    
    @Parameter
    static var reachedThresholdParameter: Bool = false
    var title: Text {
        Text("Time to clean up")
            .italic()
            .font(.title)
            .foregroundStyle(.red)
    }
    
    var message: Text? {
        Text("Start swiping from the trailing edge to delete completed ToDos")
    }
    
    var image: Image? {
        Image(systemName: "trash")
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.$reachedThresholdParameter) {
                $0 == true
            }
        ]
    }
}

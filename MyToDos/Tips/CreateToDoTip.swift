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

struct CreateToDoTip: Tip {
    var title: Text {
        Text("Create your first ToDo")
    }
    
    var message: Text? {
        Text("Tap on this button to create your first ToDo")
    }
    
    var image: Image? {
        Image(.noToDos)
    }
    
}

//
// Created for MyToDos
// by  Stewart Lynch
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import Foundation


extension FileManager {
    static var fileName = "ToDos.json"
    
    func saveDocument(contents: String, docName: String) throws {
        let url = URL.documentsDirectory.appendingPathComponent(docName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            throw ToDoError.saveError
        }
    }
    
    
    func readDocument(docName: String) throws -> Data {
        let url = URL.documentsDirectory.appendingPathComponent(docName)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw ToDoError.readError
        }
    }
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: URL.documentsDirectory.appendingPathComponent(docName).path)
    }
}


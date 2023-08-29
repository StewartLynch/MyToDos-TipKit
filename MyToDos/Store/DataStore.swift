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
import Observation

@Observable
class DataStore {
    var toDos:[ToDo] = []
    var appError: ErrorType? = nil
    var showErrorAlert = false
    var filterText = "" {
        didSet {
            filterToDos()
        }
    }
    var filteredToDos: [ToDo] = []
    
    var completeedToDosCount: Int {
        toDos.filter {$0.completed}.count
    }
    @ObservationIgnored
    var forPreview: Bool
    init(forPreview: Bool = false) {
        self.forPreview = forPreview
        if FileManager().docExist(named: FileManager.fileName){
            loadToDos()
        }
        if forPreview {
            if toDos.isEmpty {
                toDos = ToDo.sampleData
                saveToDos()
            }
        }
    }
    
    private func filterToDos() {
        if !filterText.isEmpty {
            filteredToDos = toDos.filter{$0.name.lowercased().contains(filterText.lowercased())}
        } else {
            filteredToDos = toDos
        }
    }
    func addToDo(_ toDo: ToDo) {
        toDos.append(toDo)
        filteredToDos = toDos
        saveToDos()
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDos.firstIndex(where: { $0.id == toDo.id}) else { return }
        toDos[index] = toDo
        saveToDos()
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        saveToDos()
    }
    
    func deleteToDo(_ toDo: ToDo) {
        if let indexToDelete = toDos.firstIndex(where: {$0.id == toDo.id}) {
            toDos.remove(at: indexToDelete)
            filterToDos()
            saveToDos()
        }
    }
    
    func newToDo() {
        addToDo(ToDo(name: ""))
    }
    
    
    func loadToDos() {
        do {
            let data = try FileManager().readDocument(docName: FileManager.fileName)
            let decoder = JSONDecoder()
            do {
                toDos = try decoder.decode([ToDo].self, from: data)
                filteredToDos = toDos
            } catch {
                appError = ErrorType(error: .decodingError)
                showErrorAlert = true
            }
        } catch {
            appError = ErrorType(error: .decodingError)
            showErrorAlert = true
        }
    }
    
    
    func saveToDos() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(toDos)
            let jsonString = String(decoding: data, as: UTF8.self)
            do {
                try FileManager().saveDocument(contents: jsonString, docName: FileManager.fileName)
            } catch {
                appError = ErrorType(error: error as! ToDoError)
                showErrorAlert = true
            }
        } catch {
            appError = ErrorType(error: .encodingError)
            showErrorAlert = true
        }
    }
}


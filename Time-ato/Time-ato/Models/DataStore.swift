import Foundation

struct DataStore {
  func dataFileURL() -> URL? {
      let fileManager = FileManager.default

      
      do {
        
        let docsFolder = try fileManager.url(
          for: .documentDirectory,
          in: .userDomainMask,
          appropriateFor: nil,
          create: true)
        
        let dataURL = docsFolder
          .appendingPathComponent("Timeato_Tasks.json")
        return dataURL
      } catch {
        
        print("URL error: \(error.localizedDescription)")
        return nil
      }
  }

  func readTasks() -> [Task] {
    guard let url = dataFileURL() else {
      return []
    }

    do {
      let data = try Data(contentsOf: url)
      let tasks = try JSONDecoder()
        .decode([Task].self, from: data)
      return tasks
    } catch {
      print("Read error: \(error.localizedDescription)")
      return []
    }
  }

  func save(tasks: [Task]) {
    guard
      let url = dataFileURL(),
      let data = try? JSONEncoder().encode(tasks)
    else {
      return
    }
    do {
      try data.write(to: url)
    } catch {
      print("Save error: \(error.localizedDescription)")
    }
  }
}

extension Notification.Name {
    static let dataRefreshNeeded = Notification.Name("dataRefreshNeeded")
}

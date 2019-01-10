//
//  ItemsModel.swift
//  ToDoList
//
//  Created by Alex Paul on 1/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

final class ItemsModel {
  private static var items = [Item]()
  
  static func getItems() -> [Item] {
    // get file path
    let path = DataPersistenceManager.filePathFromDocumentsDirectory(filename: DataPersistenceManager.filename).path
    
    // does file exist
    if FileManager.default.fileExists(atPath: path) {
      // get contents at path
      if let data = FileManager.default.contents(atPath: path) {
        do {
          self.items = try PropertyListDecoder().decode([Item].self, from: data)
        } catch {
          print("decoding error: \(error)")
        }
      }
    }
    items = items.sorted { $0.date > $1.date }
    return items
  }
  
  static func saveItem(item: Item) {
    // append to array
    items.append(item)
    save()
  }
  
  static func save() {
    // encode items array to data
    do {
      let data = try PropertyListEncoder().encode(items)
      // write to the disk
      try data.write(to: DataPersistenceManager.filePathFromDocumentsDirectory(filename: DataPersistenceManager.filename),
                     options: Data.WritingOptions.atomic)
    } catch {
      print("encoding error: \(error)")
    }
  }
  
  static func delete(item: Item, atIndex index: Int) {
    items.remove(at: index)
    save()
  }
  
  static func update(item: Item, atIndex index: Int) {
    items[index] = item
    save()
  }
}

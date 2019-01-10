//
//  DataPersistenceManager.swift
//  ToDoList
//
//  Created by Alex Paul on 1/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
  private init() {}
  
  static let filename = "ToDoList.plist"
  
  static func documentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  
  static func cachesDirectory() -> URL {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
  }
  
  static func filePathFromDocumentsDirectory(filename: String) -> URL {
    return documentsDirectory().appendingPathComponent(filename)
  }
  
  static func filePathFromCachesDirectory(filename: String) -> URL {
    return cachesDirectory().appendingPathComponent(filename)
  }
}

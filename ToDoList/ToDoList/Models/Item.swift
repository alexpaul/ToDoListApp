//
//  Item.swift
//  ToDoList
//
//  Created by Alex Paul on 1/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct Item: Codable, Equatable {
  let title: String
  let description: String
  let createdAt: String
  
  public var date: Date {
    let isoDateFormatter = ISO8601DateFormatter()
    let date = isoDateFormatter.date(from: createdAt)
    return date ?? Date() 
  }
  
  public var formattedDateString: String {
    var dateString = createdAt
    let isoDateFormatter = ISO8601DateFormatter()
    if let date = isoDateFormatter.date(from: createdAt) {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"  // January 9, 2019 10:30 PM
      dateString = dateFormatter.string(from: date)
    }
    return dateString
  }
}

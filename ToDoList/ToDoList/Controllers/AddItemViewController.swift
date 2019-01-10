//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Alex Paul on 1/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var descriptionTextView: UITextView!
  
  private let titleTextViewPlaceholder = "Title"
  private let descriptionTextViewPlaceholder = "Item Description"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleTextView.delegate = self
    descriptionTextView.delegate = self
    
    titleTextView.textColor = .lightGray
    titleTextView.text = titleTextViewPlaceholder

    descriptionTextView.textColor = .lightGray
    descriptionTextView.text = descriptionTextViewPlaceholder
  }
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addItem(_ sender: UIBarButtonItem) {
    guard let itemTitle = titleTextView.text,
      let itemDescription = descriptionTextView.text else {
        // handle case
        return
    }
    
    // create an instance of the Item object
    let date = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withInternetDateTime, .withFullDate, .withFullTime, .withDashSeparatorInDate, .withTimeZone]
    let timestamp = isoDateFormatter.string(from: date)
    
    let item = Item(title: itemTitle, description: itemDescription, createdAt: timestamp)
    
    // save to disk
    ItemsModel.saveItem(item: item)
    
    dismiss(animated: true, completion: nil)
  }

}

extension AddItemViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == titleTextViewPlaceholder || textView.text == descriptionTextViewPlaceholder {
      textView.textColor = .black
      textView.text = ""
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView == titleTextView {
      if textView.text == "" {
        textView.textColor = .lightGray
        textView.text = titleTextViewPlaceholder
      }
    } else if textView == descriptionTextView {
      if textView.text == "" {
        textView.textColor = .lightGray
        textView.text = descriptionTextViewPlaceholder
      }
    }
  }
}

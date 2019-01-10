//
//  ListDetailViewController.swift
//  ToDoList
//
//  Created by Alex Paul on 1/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var descriptionTextView: UITextView!
  
  private var isEditingList = false
  
  public var item: Item!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextViewDefaults()
    updateUI()
  }
  
  private func updateUI() {
    navigationItem.title = item.title
    titleTextView.text = item.title
    descriptionTextView.text = item.description
  }
  
  private func setupTextViewDefaults() {
    disableTextViewEditing(isEditingList: false)
  }
  
  @IBAction func editList(_ sender: UIBarButtonItem) { // currently editing
    isEditingList = isEditingList == false ? true : false
    if isEditingList {
      disableTextViewEditing(isEditingList: true)
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEditing))
      
      titleTextView.becomeFirstResponder()
    }
  }
  
  @objc private func doneEditing() {
    disableTextViewEditing(isEditingList: false)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editList(_:)))
    isEditingList = false
    
    guard let itemTitle = titleTextView.text,
      let itemDescription = descriptionTextView.text else {
        // handle
        return
    }
    
    let itemToBeUpdated = Item.init(title: itemTitle, description: itemDescription, createdAt: item.createdAt)
    
    if let index = ItemsModel.getItems().firstIndex(of: item) {
      ItemsModel.update(item: itemToBeUpdated, atIndex: index)
    }
  }
  
  private func disableTextViewEditing(isEditingList: Bool) {
    titleTextView.isEditable = isEditingList
    descriptionTextView.isEditable = isEditingList
  }
}

//
//  ViewController.swift
//  ToDoList
//
//  Created by Alex Paul on 1/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    print(DataPersistenceManager.documentsDirectory())
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = tableView.indexPathForSelectedRow,
      let detailViewController = segue.destination as? ListDetailViewController else {
        return
    }
    let item = ItemsModel.getItems()[indexPath.row]
    detailViewController.item = item
  }
}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ItemsModel.getItems().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    let item = ItemsModel.getItems()[indexPath.row]
    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.formattedDateString
    return cell
  }
}

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // remove the item from the model
    ItemsModel.delete(item: ItemsModel.getItems()[indexPath.row], atIndex: indexPath.row)

    // remove the row from the table view 
    tableView.deleteRows(at: [indexPath], with: .fade)
  }
}

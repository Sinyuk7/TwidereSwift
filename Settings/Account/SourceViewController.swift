//
//  SourceViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/24.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
import CC

class SourceViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.setEditing(true, animated: true)
        tableView.allowsSelectionDuringEditing = true
        register(tableView, cell: SourceCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(tableView, cell: SourceCell.self, indexPath: indexPath)
        cell.bind(screenName: "Sinyuk \(indexPath.row)", id: "@sinyuk\(indexPath.row)", urlFor: nil)
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        mainStore.dispatch(SetRouteAction([SettingsNavViewController.route(),
                                           SettingsTabViewController.route(),
                                           EditSourceController.route()]))
    }
    
}



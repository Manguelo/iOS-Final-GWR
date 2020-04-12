//
//  SecondViewController.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        ScheduleStore.shared.favoritePrograms = ScheduleStore.shared.programs.filter({ (p) -> Bool in
            p.favorite
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScheduleStore.shared.favoritePrograms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesCell
        cell.programLabel.text = ScheduleStore.shared.favoritePrograms[indexPath.row].title
        cell.artistLabel.text = ScheduleStore.shared.favoritePrograms[indexPath.row].artist
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fave = ScheduleStore.shared.favoritePrograms[indexPath.row]
            fave.favorite = false
            ScheduleStore.shared.favoritePrograms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.instance.save()
        }
    }
    
    @IBAction func editPressed(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
}


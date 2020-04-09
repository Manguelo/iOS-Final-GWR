//
//  SecondViewController.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        ScheduleStore.shared.filteredPrograms = ScheduleStore.shared.programs
    }
    
    var searchActive : Bool = false
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell") as! ProgramCell;
        cell.programLabel.text = ScheduleStore.shared.filteredPrograms[indexPath.row].title
        cell.artistLabel.text = ScheduleStore.shared.filteredPrograms[indexPath.row].artist
        cell.timeLabel.text = ScheduleStore.shared.militaryToStandardTime(program: ScheduleStore.shared.filteredPrograms[indexPath.row])
        cell.timeLengthLabel.text = ScheduleStore.shared.filteredPrograms[indexPath.row].timeLength
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScheduleStore.shared.filteredPrograms.count
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        ScheduleStore.shared.filteredPrograms = ScheduleStore.shared.programs.filter{
            $0.title.contains(searchBar.text)
        }
        if(ScheduleStore.shared.filteredPrograms.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
}


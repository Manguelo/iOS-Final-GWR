//
//  SecondViewController.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScheduleStore.shared.filteredPrograms = ScheduleStore.shared.programs
        searchBar.delegate = self
    }
    
    var searchActive : Bool = false
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell;
        cell.pName.text = ScheduleStore.shared.filteredPrograms[indexPath.row].title
        cell.pArtist.text = ScheduleStore.shared.filteredPrograms[indexPath.row].artist
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        ScheduleStore.shared.filteredPrograms = ScheduleStore.shared.programs.filter{
            (p) -> Bool in
            p.title?.lowercased().range(of: searchBar.text?.lowercased() ?? "") != nil || ((p.artist?.lowercased().range(of: searchBar.text?.lowercased() ?? "")) != nil)
        }
        var seen = Set<String>()
        var unique: [Program] = []
        for program in ScheduleStore.shared.filteredPrograms{
            if !seen.contains(program.title!) {
                unique.append(program)
                seen.insert(program.title!)
                
            }
        }
        ScheduleStore.shared.filteredPrograms = unique
        if(ScheduleStore.shared.filteredPrograms.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
}


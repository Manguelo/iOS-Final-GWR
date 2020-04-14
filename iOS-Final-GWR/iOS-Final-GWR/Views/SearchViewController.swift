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
        removeDuplicates()
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
        
        if searchBar.text == "" {
            ScheduleStore.shared.filteredPrograms = ScheduleStore.shared.programs
            removeDuplicates()
            return
        }
        
        ScheduleStore.shared.filteredPrograms = ScheduleStore.shared.programs.filter{
            (p) -> Bool in
            p.title?.lowercased().range(of: searchBar.text?.lowercased() ?? "") != nil || ((p.artist?.lowercased().range(of: searchBar.text?.lowercased() ?? "")) != nil)
        }
        removeDuplicates()
        
        if(ScheduleStore.shared.filteredPrograms.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    func removeDuplicates() {
        var seen = Set<String>()
        var unique: [Program] = []
        for program in ScheduleStore.shared.filteredPrograms{
            if !seen.contains(program.title!) {
                unique.append(program)
                seen.insert(program.title!)
                
            }
        }
        unique = unique.sorted() { $0.title ?? "" < $1.title ?? "" }
        ScheduleStore.shared.filteredPrograms = unique
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            if let index = tableView.indexPathForSelectedRow?.row {
                ScheduleStore.shared.selectedProgram = ScheduleStore.shared.filteredPrograms[index]
            }
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            searchBar.text = ""
            ScheduleStore.shared.filteredPrograms = ScheduleStore.shared.programs
            removeDuplicates()
            tableView.reloadData()
        }
    }
}


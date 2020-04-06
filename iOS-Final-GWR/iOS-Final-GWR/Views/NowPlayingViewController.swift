//
//  FirstViewController.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import UIKit
import CoreData

class NowPlayingViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var nowPlayingTitle: UILabel!
    @IBOutlet weak var nowPlayingArtist: UILabel!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         Uncomment this to reset core data
         CoreDataManager.instance.clearCoreData(entity: "Program")
         */
 
        ScheduleStore.shared.programs = CoreDataManager.instance.getAllSavedPrograms()
        if ScheduleStore.shared.programs.isEmpty {
            let result = ScheduleStore.shared.getSchedule()
            for item in result["programs"]! {
                CoreDataManager.instance.saveProgram(
                    title: item["title"] as! String,
                    artist: item["artist"] as! String,
                    time: item["time"] as! Int,
                    favorite: false,
                    timeLength: item["timeLength"] as! String)
            }
            ScheduleStore.shared.programs = CoreDataManager.instance.getAllSavedPrograms()
        }
        
        // Timer to update what's currently playing
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateNowPlaying), userInfo: nil, repeats: true)
        // Update wha's currently playing
        updateNowPlaying()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScheduleStore.shared.programsComingUp.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell") as! ProgramCell;
        cell.programLabel.text = ScheduleStore.shared.programsComingUp[indexPath.row].title
        cell.artistLabel.text = ScheduleStore.shared.programsComingUp[indexPath.row].artist
        cell.timeLabel.text = ScheduleStore.shared.militaryToStandardTime(program: ScheduleStore.shared.programsComingUp[indexPath.row])
        cell.timeLengthLabel.text = ScheduleStore.shared.programsComingUp[indexPath.row].timeLength
        return cell
    }
    
    @objc func updateNowPlaying() {
        let current = ScheduleStore.shared.getNowPlaying();
        if (current == nil) {
            nowPlayingTitle.text = "God's Way Radio"
            nowPlayingArtist.text = "104.7 WAYG"
        } else {
            nowPlayingTitle.text = current!.title
            nowPlayingArtist.text = current!.artist
        }
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        currentTime.text = dateString
        
        tableView.reloadData()
    }
}



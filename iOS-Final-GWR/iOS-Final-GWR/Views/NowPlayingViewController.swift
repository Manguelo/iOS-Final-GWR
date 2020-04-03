//
//  FirstViewController.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import UIKit
import CoreData

class NowPlayingViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
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
        }
    }
}



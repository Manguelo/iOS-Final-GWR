//
//  ScheduleStore.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import Foundation

class ScheduleStore {
    static let shared = ScheduleStore()
    
    private init() {}
    
    // Main list containg program info pulled from a json
    var programs: [String : String] = [:]
    
    // Use this for the search functionality
    var filteredPrograms: [String : String] = [:]
    
    
    let itemArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("schedule.archive")
    }()
    
    func getSchedule() {
        
    }
    
    // save current shared object to file
    func archiveStore() {
        if NSKeyedArchiver.archiveRootObject(ScheduleStore.shared, toFile: itemArchiveURL.path) {
            print ("File written")
        } else {
            print ("Write Failed")
        }
    }
    
    // get shared object and assign values to current store
    func unarchiveStore() {
        if let store = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? ScheduleStore {
            self.programs = store.programs
            self.filteredPrograms = store.filteredPrograms
        } else {
            print ("file not found")
        }
    }
}

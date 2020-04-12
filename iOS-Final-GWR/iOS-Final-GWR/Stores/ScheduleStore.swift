//
//  ScheduleStore.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import Foundation
import CoreData

class ScheduleStore {
    static let shared = ScheduleStore()
    
    private init() {}
    
    // Main list containg program info pulled from a json
    var programs: [Program] = []
    
    // List of upcoming programs
    var programsComingUp: [Program] = []
    
    // Use this for the search functionality
    var filteredPrograms: [Program] = []
    
    // List of favorite programs
    var favoritePrograms: [Program] = []
    
    var selectedProgram: Program!
    
    func getSchedule() -> [String : [Dictionary<String, AnyObject>]] {
        if let path = Bundle.main.path(forResource: "schedule_json", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                return jsonResult as! [String : [Dictionary<String, AnyObject>]]
            } catch {
                print("Error parsing schedule!")
            }
        }
        return [:]
    }
    
    func getNowPlaying() -> Program? {
        var program: Program!
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        let curTime = (hour * 100) + minutes; // Convert to military time
        var i = 0;
        var displayed = false;
        
        while (!displayed) {
            if programs.count == 0 {
                return nil
            }
            //If it has gone through all of array
            if (i >= programs.count - 1) {
                displayed = true;
                program = programs[i];
            } else if (curTime >= programs[i].time && curTime < programs[i + 1].time) {
                displayed = true;
                program = programs[i];
            } else {
                i += 1;
            }
        }
        programsComingUp = Array(programs[i + 1...programs.count - 1])
        return program
    }
    
    func militaryToStandardTime(program: Program) -> String {
        var timeAsString = "\(program.time)"
        
        if timeAsString.count == 3 {
            timeAsString.insert(":", at: timeAsString.index(timeAsString.startIndex, offsetBy: 1))
        } else if timeAsString.count == 4 {
            timeAsString.insert(":", at: timeAsString.index(timeAsString.startIndex, offsetBy: 2))
        } else if program.time == 0 { // 12:00 AM
            timeAsString = "00:00"
        } else if program.time == 30{ // 12:30 AM
            timeAsString = "00:30"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = dateFormatter.date(from: timeAsString) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func getCurrentTime() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = Date()
        return dateFormatter.string(from: date)
    }
}

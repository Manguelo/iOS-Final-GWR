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
    
    // Use this for the search functionality
    var filteredPrograms: [Program] = []
    
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
}

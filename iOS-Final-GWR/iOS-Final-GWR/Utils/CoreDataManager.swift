//
//  CoreDataManager.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 4/2/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    private init () {}
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func getAllSavedPrograms() -> [Program] {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Program")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
        do {
            return try context!.fetch(fetchRequest) as! [Program]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func saveProgram(title: String, artist: String, time: Int, favorite: Bool, timeLength: String) {
        // see if program exists
        let result = getAllSavedPrograms()
        var program = result.first { (p) -> Bool in
            p.title! + "\(p.time)" == title + "\(time)"
        }
        
        // if program does not exist create a new one
        if program == nil {
            program = Program(context: context!)
        }
        
        program?.title = title
        program?.artist = artist
        program?.time = Int64(time)
        program?.favorite = favorite
        program?.timeLength = timeLength
        
        do {
            try context!.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func clearCoreData(entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context!.execute(deleteRequest)
            try context!.save()
        } catch {
            print ("There was an error clear core data")
        }
    }
}

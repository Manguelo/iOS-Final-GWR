//
//  SecondViewController.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var favoritesItem: UIBarButtonItem!
    @IBOutlet weak var programTitle: UILabel!
    @IBOutlet weak var programArtist: UILabel!
    @IBOutlet weak var programTimes: UILabel!
    @IBOutlet weak var programInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (ScheduleStore.shared.selectedProgram.favorite) {
            favoritesItem.tintColor = navigationController?.navigationBar.tintColor
        }
        programTitle.text = ScheduleStore.shared.selectedProgram.title
        programArtist.text = ScheduleStore.shared.selectedProgram.artist
        programTimes.text = getProgramTimes()
        programInfo.text = String.loremIpsum(paragraphs: 1)
    }
    
    @IBAction func selectedFavorite(_ sender: Any) {
        if (ScheduleStore.shared.selectedProgram.favorite) {
            favoritesItem.tintColor = UIColor.lightGray
            ScheduleStore.shared.selectedProgram.favorite = false;
            CoreDataManager.instance.save()
        } else {
            favoritesItem.tintColor = navigationController?.navigationBar.tintColor
            ScheduleStore.shared.selectedProgram.favorite = true;
            CoreDataManager.instance.save()
        }
    }
    
    func getProgramTimes() -> String {
        var times = "Weekdays: "
        let program = ScheduleStore.shared.selectedProgram
        let programs = ScheduleStore.shared.programs.filter { (p) -> Bool in
            p.title == program?.title && p.artist == program?.artist
        }
        
        for p in programs {
           times += "\(ScheduleStore.shared.militaryToStandardTime(program: p)), "
        }
        times.removeLast(2)
        return times
    }
}


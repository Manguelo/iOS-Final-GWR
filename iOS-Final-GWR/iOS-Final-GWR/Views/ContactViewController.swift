//
//  SecondViewController.swift
//  iOS-Final-GWR
//
//  Created by Matthew Anguelo on 3/31/20.
//  Copyright © 2020 Matthew Anguelo. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    
    @IBAction func clickedPhone(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://7863133115")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func clickedEmail(_ sender: Any) {
        UIApplication.shared.open(URL(string: "mailto:manager@godswayradio.com")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func clickedAddress(_ sender: Any) {

        let address = "11975,SW+2+Street,Miami,FL,33184,USA"
        
        if let url = URL(string:"http://maps.apple.com/?address=\(address)") {
            UIApplication.shared.open(url)
        }

    }
    
}


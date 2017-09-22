//
//  EventDetailsViewController.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/18/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var songkickLink: UIButton!
    
    var eventAnnotation: EventAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let annotation = eventAnnotation {
            artistNameLabel.text = annotation.artistName ?? annotation.eventName
            venueNameLabel.text = annotation.venueName
            eventDateLabel.text = annotation.displayDate
        }
    }
    
    @IBAction func SongkickLinkClick(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "http://www.stackoverflow.com")!)
    }
    
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

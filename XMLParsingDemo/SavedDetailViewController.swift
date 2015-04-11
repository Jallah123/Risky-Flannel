//
//  SavedDetailViewController.swift
//  XMLParsingDemo
//
//  Created by Joris Huijbregts on 11/04/2015.
//
//

import UIKit

class SavedDetailViewController : UIViewController {
    
    var serie: Serie?
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var toastMessage: UITextField!
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var amountOfSeasons: UILabel!
    @IBOutlet weak var totalEpisodes: UILabel!
    @IBOutlet weak var firstAired: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var status: UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        seriesName.text = "asdasdasd"
    }
}
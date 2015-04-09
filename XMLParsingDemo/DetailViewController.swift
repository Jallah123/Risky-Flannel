//
//  DetailViewController.swift
//  XMLParsingDemo
//
//  Created by Jelle van Es on 08/04/15.
//
//
import UIKit

class DetailViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var amountOfSeasons: UILabel!
    @IBOutlet weak var totalEpisodes: UILabel!
    @IBOutlet weak var firstAired: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var status: UILabel!
    var id : String?
    var name : String?
    var serie: Serie?

    
    @IBAction func onSave(sender: UIButton) {
    }
    @IBAction func onDelete(sender: UIButton) {
    }
    override func viewDidLoad()
    {
        //http://thetvdb.com/api/983E743A757CA344/series/257655/all
        super.viewDidLoad()
//        let session = NSURLSession.sharedSession()
//        let url = NSURL(string: "http://thetvdb.com/api/983E743A757CA344/series/" + self.id! + "/all")
//        let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
//            if let theData = data {
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.series = self.parser.beginParsing(data)
//                    self.tbData.reloadData()
//                })
//            }
//        })
//        task.resume()

    }
}

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
        parser = Parser()
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
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
    var parser: Parser
    var serie: Serie?
    var xml: NSString?
    var defaults = NSUserDefaults.standardUserDefaults()

    
    @IBAction func onSave(sender: UIButton) {
        
        var series = defaults.objectForKey("series") as? [NSString]
        if series == nil {
            series = [NSString]()
        }
        
        if series!.count != 0 {
            for s in series! {
                if s as NSString == xml! {
                    showMessage("Already saved")
                return
                }
            }
        }

        series!.append(xml!)
        
        defaults.setValue(series, forKey: "series")
        defaults.synchronize()
        showMessage("Serie saved")
    }
    @IBAction func onDelete(sender: UIButton) {
        var series = defaults.objectForKey("series") as? [NSString]
        if series == nil {
            showMessage("Not saved yet")
            return
        }
        if series!.count != 0 {
            var i = 0
            for s in series! {
                if s as NSMutableString == xml! {
                    showMessage("Deleted")
                    series!.removeAtIndex(i)
                    defaults.setValue(series, forKey: "series")
                    defaults.synchronize()
                    return
                }
                i++
            }
        }
        showMessage("Not saved yet")
    }
    override func viewDidLoad()
    {
        //http://thetvdb.com/api/983E743A757CA344/series/257655/all
        super.viewDidLoad()
        
        toastMessage.textColor = UIColor.blueColor()
        
        let backButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.Plain, target: self, action: "popToRoot")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Arial", size: 20)!], forState: UIControlState.Normal)
        
        let session = NSURLSession.sharedSession()
        let id = (self.serie!.seriesId as NSString).substringToIndex(self.serie!.seriesId.length - 1)
        
        let url = NSURL(string: "http://thetvdb.com/api/983E743A757CA344/series/" + id + "/all")
        let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let theData = data {
                dispatch_async(dispatch_get_main_queue(), {
                    let series = self.parser.beginParsing(data)
                    if series.count != 1 {
                        return
                    }
                    self.xml = NSString(data: data, encoding: UInt())
                    self.serie = series[0]
                    self.navigationItem.title = self.serie?.name
                    self.fillView()
                    self.saveButton.enabled = true
                    self.deleteButton.enabled = true
                })
            }
        })
        task.resume()
    }
    
    func showMessage(message: String) {
        toastMessage.text = message
        toastMessage.hidden = false
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.75 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.toastMessage.hidden = true
        }
    }
    
    func popToRoot(sender: UIBarButtonItem) {
        //self.performSegueWithIdentifier("detail", sender: self)
         self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "detail") {
            var svc = segue!.destinationViewController.topViewController as ViewController;
        }
    }
    
    func fillView() {
        firstAired.text = firstAired.text?.stringByAppendingString(serie!.firstAired)
        overview.text = serie?.overview
        rating.text = rating.text?.stringByAppendingString(serie!.rating!)
        status.text = status.text?.stringByAppendingString(serie!.status!)
//        firstAired.text = serie?.firstAired
//        summary.text += serie?.overview
//        rating.text += serie?.rating
//        status.text += serie?.status
    }
}

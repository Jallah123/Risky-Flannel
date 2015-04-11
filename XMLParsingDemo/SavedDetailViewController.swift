import UIKit

class SavedDetailViewController : UIViewController {
    
    var serie: Serie?
    
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var toastMessage: UITextField!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var firstAired: UILabel!
    var defaults = NSUserDefaults.standardUserDefaults()
    var xml: NSString?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillView()

        
    }
    
    func fillView() {
        self.title = serie?.name
        self.firstAired.text = self.firstAired.text?.stringByAppendingString(serie!.firstAired)
        summary.text = serie?.overview
        rating.text = rating.text?.stringByAppendingString(serie!.rating!)
        status.text = status.text?.stringByAppendingString(serie!.status!)
    }
    
    func showMessage(message: String) {
        toastMessage.text = message
        toastMessage.hidden = false
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.75 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.toastMessage.hidden = true
        }
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
                let parser = Parser()
                var xml = s.dataUsingEncoding(NSUTF8StringEncoding)
                let serie = parser.beginParsing(xml!)
                if serie[0].seriesId == self.serie?.seriesId {
                    showMessage("Deleted")
                    series!.removeAtIndex(i)
                    defaults.setValue(series, forKey: "series")
                    self.navigationController?.popViewControllerAnimated(true)
                    return
                }
                i++
            }
        }
        showMessage("Not saved yet")
    }
}
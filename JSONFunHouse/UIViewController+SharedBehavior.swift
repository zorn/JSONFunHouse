import UIKit

extension UIViewController {
    
    func presentError(error: String) {
        let alertVC = UIAlertController(title: "Error", message: error, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func presentError(error: ErrorType?) {
        if let error = error {
            presentError("\(error)")
        } else {
            print("Attempted to present an empty error.")
        }
    }
    
    func getDataFromLocalJSONFileWithName(name: String) -> NSData? {
        if let dataURL = NSBundle.mainBundle().URLForResource(name, withExtension: "json") {
            return NSData(contentsOfURL: dataURL)
        }
        return nil
    }
    
    func getDataFromFileURL(fileURL: NSURL?) -> NSData? {
        if let dataURL = fileURL {
            if let data = NSData(contentsOfURL: dataURL) {
                return data
            }
        }
        return nil
    }
}

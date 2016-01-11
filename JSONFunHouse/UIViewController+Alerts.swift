import UIKit

extension UIViewController {
    
    func presentError(error: ErrorType?) {
        if let error = error {
            let alertVC = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alertVC, animated: true, completion: nil)
        } else {
            print("Attempted to present an empty error.")
        }
    }
    
}

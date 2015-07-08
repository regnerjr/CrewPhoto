import UIKit
import Parse
import ParseUI
//import FBSDKCoreKit
//import FBSDKLoginKit


class ViewController: UIViewController {

    lazy var login: PFLogInViewController = {
        let vc = PFLogInViewController()
        vc.delegate = self
        vc.fields = PFLogInFields.Facebook
//        login.logInView?.logo = CrewPhotoView() //add custom picture here
        return vc
        }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        showLoginIfNotLoggedIn()
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Test Parse: Object has been saved.")
        }
    }

    func showLoginIfNotLoggedIn(user: PFUser? = PFUser.currentUser()){
        //check for successfull login else show the login page
        if user == nil {
            presentViewController(login, animated: true, completion: nil)
        }
    }

}


extension ViewController: PFLogInViewControllerDelegate {
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        println("Success Logged in \(user)")
        dismissViewControllerAnimated(true, completion: nil)
    }

    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Login failed with error \(error?.localizedDescription)")
        //show an alert that states to ensure facebook.app is logged in
        let alert = UIAlertController(title: "Login Error", message: "Ensure Facebook is Installed and Logged In", preferredStyle: UIAlertControllerStyle.Alert)
        let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(button)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

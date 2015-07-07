import UIKit
import Parse
import ParseUI
//import FBSDKCoreKit
//import FBSDKLoginKit


class ViewController: UIViewController {

    let login = PFLogInViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        login.delegate = self
        login.fields = PFLogInFields.Facebook
//        login.logInView?.logo = CrewPhotoView()
    }

    override func viewDidAppear(animated: Bool) {
        presentViewController(login, animated: true, completion: nil)
    }

}

extension ViewController: PFLogInViewControllerDelegate {
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        println("Success Logged in \(user)")
    }
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        print("Do Something on Cancel")
    }
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Login failed with error \(error?.localizedDescription)")
    }
}

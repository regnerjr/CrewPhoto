import UIKit

import Bolts
import Parse
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //--------------------------------------
    // MARK: - UIApplicationDelegate
    //--------------------------------------
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Parse.enableLocalDatastore()

        if let path = NSBundle.mainBundle().pathForResource("keys", ofType: "plist"),
            dict = NSDictionary(contentsOfFile: path),
            let applicationId = dict["parseApplicationId"] as? String,
            let clientKey = dict["parseClientKey"] as? String{

            // Initialize Parse.
            Parse.setApplicationId(applicationId, clientKey: clientKey)
        } else {
            println("Parse not initialized correctly")
        }

        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)

//        PFUser.enableAutomaticUser()

//        let defaultACL = PFACL();

        // If you would like all objects to be private by default, remove this line.
//        defaultACL.setPublicReadAccess(true)

//        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)

        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)

        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance()
            .application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

}

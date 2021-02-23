//
//  AppDelegate.swift
//  Volunteer
//
//  Created by Karina Naranjo on 2/16/21.
//

import UIKit
import Parse

let primaryColor = UIColor(red: 255/255, green: 254/255, blue: 253/255, alpha: 1)
let secondaryColor = UIColor(red: 150/255, green: 211/255, blue: 242/255, alpha: 1)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Settings to connect to the Back4App Servers
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "DJHIxXfSbWsFNYEL2g1r9w1sXx2NIdzT8n4EAyxH"
            $0.clientKey = "vKtzIx3sMQIM67fByLTQ8C2BIvKB5aRFQiTu40nU"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        
        // Configuration of the Parse
        saveInstallationObject()
        
        // Override point for customization after application launch.
        return true
    }
    
    // Creates a new parse installation object upon the app loading 
    
    func saveInstallationObject(){
            if let installation = PFInstallation.current(){
                installation.saveInBackground {
                    (success: Bool, error: Error?) in
                    if (success) {
                        print("You have successfully connected your app to Back4App!")
                    } else {
                        if let myError = error{
                            print(myError.localizedDescription)
                        }else{
                            print("Uknown error")
                        }
                    }
                }
            }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


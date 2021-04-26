//
//  AppDelegate.swift
//  Volunteer
//
//  Created by Karina Naranjo on 2/16/21.
//

import UIKit
import Parse

let primaryColor = UIColor(red: 191/255, green: 238/255, blue: 255/255, alpha: 1)
let secondaryColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Settings to connect to the Back4App Servers
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "X8fFrsxxu4oJ03gstRsWL4rm3QKZVcuvooJIYLZS"
            $0.clientKey = "tlTEqq932IPjXNmtLZUX0yufoK2ZvUap92mY5v0C"
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

class SideMenuListController: UITableViewController {
    var Users = [PFObject]()
    
    public var delegate: MenuControllerDelegate?
    private let menuItems: [SideMenuItem]
    private let sideBarColor = UIColor(red: 75/225.0, green: 75/225.0, blue: 75/225.0, alpha: 1)
    
    init(with menuItems: [SideMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = sideBarColor
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 100))
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let userProfileImage = UIImageView(frame: CGRect(x: 40,y: 5,width: 60,height: 60))
        userProfileImage.image = UIImage(named:"image var name from database")
        view.addSubview(userProfileImage)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.backgroundColor = sideBarColor
        cell.contentView.backgroundColor = sideBarColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
}


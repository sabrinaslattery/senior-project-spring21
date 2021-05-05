//
//  AboutUsViewController.swift
//  Volunteer
//
//  Created by Joshua Freedman on 3/30/21.
//

import UIKit
import SafariServices

class AboutUsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped() {
        
        let vc = SFSafariViewController(url: URL(string: "https://wearecolorblind.com/resources/collection/resources-for-designing-for-the-colorblind/")!)
        
        present(vc, animated:true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
 
}

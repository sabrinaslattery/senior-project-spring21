//
//  BackButton.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 4/11/21.
//

import UIKit

class BackButton: UIButton {

    func backAction() -> Void {
        self.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
            //dismiss(animated: true, completion: nil)
    //        navigationController?.popViewController(animated: true)
        }

}

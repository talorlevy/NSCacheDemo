//
//  HomeViewController.swift
//  JsonDataExample
//
//  Created by Talor Levy on 2/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
// MARK: @IBAction
    
    @IBAction func goToVC2(_ sender: Any) {
        guard let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagesViewController") as? ImagesViewController else { return }
        self.navigationController?.pushViewController(vc2, animated: false)
    }
}

//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by June2020 on 4/24/21.
//

import UIKit
import Foundation

// MARK: - MemeDetailViewController: UIViewController

class MemeDetailViewController: UIViewController {
    
    // MARK: Properties

var meme: Meme!
    
    // https://useyourloaf.com/blog/upside-down-and-rotating-iphones/
    
   // override var supportedInterfaceOrientations: UIInterfaceOrientationMask {set {[.portrait]}}
    
    // MARK: Outlets
    
    @IBOutlet weak var memeImage: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImage.image = self.meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
      //  supportedInterfaceOrientations()
      //  override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    
    // https://stackoverflow.com/questions/36358032/override-app-orientation-setting/48120684#48120684
    
    func setAutoRotation(value: Bool) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
       appDelegate.autoRotation = value
    }
    }
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImage.image = self.meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
        setAutoRotation(value: false) // https://stackoverflow.com/questions/36358032/override-app-orientation-setting/48120684#48120684
        // Do any additional setup after loading the view.
      //  supportedInterfaceOrientations()
      //  override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        setAutoRotation(value: true)  // https://stackoverflow.com/questions/36358032/override-app-orientation-setting/48120684#48120684
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
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



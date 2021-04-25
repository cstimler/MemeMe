//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by June2020 on 4/23/21.
//

import UIKit
import Foundation

class SentMemesCollectionViewController: UICollectionViewController {

    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        // Do any additional setup after loading the view.
   //     callNotificationAdd()
        self.loadView()
        
    }
    
    func callNotificationAdd() {
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func rotated(_notification: Notification) {
               if UIDevice.current.orientation.isLandscape {
                       let space:CGFloat = 3.0
                let dimension = (view.frame.size.width - (5*space))/6.0
                       flowLayout.minimumInteritemSpacing = space
                       flowLayout.minimumLineSpacing = space
                           flowLayout.itemSize = CGSize(width:dimension, height:dimension)
                   
               } else {
                    
                       
                       let space:CGFloat = 3.0
                let dimension = (view.frame.size.width - (2*space))/3.0
                       flowLayout.minimumInteritemSpacing = space
                       flowLayout.minimumLineSpacing = space
                           flowLayout.itemSize = CGSize(width:dimension, height:dimension)
                   
               }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UIDevice.current.orientation.isLandscape {
                let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (5*space))/6.0
                flowLayout.minimumInteritemSpacing = space
                flowLayout.minimumLineSpacing = space
                    flowLayout.itemSize = CGSize(width:dimension, height:dimension)
            
        } else {      // unfortunately this includes upside down
             
                
                let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (2*space))/3.0
                flowLayout.minimumInteritemSpacing = space
                flowLayout.minimumLineSpacing = space
                    flowLayout.itemSize = CGSize(width:dimension, height:dimension)
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    
    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(self.memes.count)
        return self.memes.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var dimension: Int
        var tempcell: UIImage!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        tempcell = meme.memedImage
        let space:CGFloat = 3.0
        if UIDevice.current.orientation.isLandscape {
            dimension = Int((view.frame.size.width - (5*space))/6.0)} else {
                dimension = Int((view.frame.size.width - (2*space))/3.0)
            }
        tempcell = tempcell.imageResize(sizeChange: CGSize(width: dimension, height: Int(Double(dimension)*2.2))) // uses code from "ResizeImage.swift"
        cell.imageView.image = tempcell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
   /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let xPadding = 10
            let spacing = 10
            let rightPadding = 10
            let width = (CGFloat(UIScreen.main.bounds.size.width) - CGFloat(xPadding + spacing + rightPadding))/2
            let height = CGFloat(515)

            return CGSize(width: width, height: height)
        }   */

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

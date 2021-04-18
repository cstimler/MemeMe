//
//  ViewController.swift
//  ImagePicker
//
//  Created by June2020 on 4/7/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {

    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // imagePickerView is the location of the image to be chosen.
    // We use a property observer to determine whether or not the shareButton should be enabled:
   
    @IBOutlet weak var imagePickerView: UIImageView!
  /* Here is code that I had tried (using a property observer), but it didn't work!!  It seems that even when a new image is loaded into the imagePickerView, it doesn't call a "didSet" event.  And I just couldn't get a hold of a UIImage view to use.  The compiler didn't like anything like var image = imagePickerView.image stating that the imagePickerView gets instantiated after vars are registered.  I even tried placing this type of statement in one of the life-cycle functions but then I had issues with its not being a global variable.  Nevertheless, I solved the problem another way by just being careful where I placed my enabled code.
     
    @IBOutlet weak var imagePickerView: UIImageView!
    {
        didSet {
            if let shareButton = shareButton {
                if let imagePickerView = imagePickerView {
                if imagePickerView.image == nil {
                shareButton.isEnabled = true
            } else {
                shareButton.isEnabled = true
            }
            }
        }
    }
    }
 */
    // This is the camera button:
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // This is the top text field:
    @IBOutlet weak var topTextField: UITextField!
    
    // This is the bottom text field:
    @IBOutlet weak var bottomTextField: UITextField!
    
    /* Need to create an outlet for the share button in order to anchor the "popover" menu for the iPads
       as well as to change properties with a property observer */
    
    
    
    // Here are the attributes that characterize the "written in text"
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40),
        NSAttributedString.Key.strokeWidth: -5
    ]
    
    // These are the components that make up the Meme:
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    

    // Determine whether or not to enable the camera button depending upon whether or not the camera is available
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
        subscribeToKeyboardNotifications()
    }

    // Register the text delegates, initialize the text fields:
    override func viewDidLoad() {
        super.viewDidLoad()
       // ViewController.originalImage = self
        // I set some of these defaults already in the storyboard, but will repeat them here to be sure:
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
    }

    // Do some housekeeping when the view controller exits including unsubscribing from notificaitons:
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // Boilerplate for showing and selecting an image from the Image Picker:
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        
        pickerController.sourceType = .photoLibrary
        
        present(pickerController, animated: true, completion: nil)
    }
    // need void function for "pickAnImageFromCamera" completion below
    
    func enableShareButton() {
        shareButton.isEnabled = true
    }
    
    // Boilerplate for enabling the camera as source type:
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
            
        shareButton.isEnabled = true

            let imagePicker = UIImagePickerController()
        
            imagePicker.delegate = self
        
            imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: enableShareButton)
        }
    
    // This function places the selected image as the display image:
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage
        
        { imagePickerView.image = image}
        
        
        
        dismiss(animated: true, completion: enableShareButton)
        
        
    }
    
    // This function dismisses the Image Picker:
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // Ensure that when user starts editing the text fields the pre-existing text is removed:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == topTextField {
        topTextField.text = ""
    }
        if textField == bottomTextField {
            bottomTextField.text = ""
        }
    }
    
    // This function is necessary so that when the user presses return the text field is no longer the "focus" so
    // the keyboard can retract:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // This moves the view upwards to make room for the keyboard when the text field editing begins:
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    // This moves the view back down when text editing ends (when the return key is pressed);
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    // This furnishes the keyboard height to the function "keyboardWillShow" above
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // Following the pub-sub pattern here the functions "keyboardWillShow" and "keyboardWillHide" become "aware" of
    // the events upon which the keyboard appears and then retracts.
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // This function provides the actions to unsubscribe which are called in the function "viewWillDisappear" above
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    
    // This function constructs the image as an object which can be forwarded to the destination chosen in the
    // ActivityViewController below:
    func generateMemedImage() -> UIImage {
        // temporarily hide the toolbar and navigationBar for
        // a better image:
        
        toolbar.isHidden = true
        navigationBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // restore toolbar and navigationBar:
        toolbar.isHidden = false
        navigationBar.isHidden = false
        
        return memedImage
    }
    
    // saves "meme" as an object:
    func save() {
        
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }

    // Resets view to initial view if the user presses "Cancel"
    @IBAction func leaveView(_ sender: Any) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
        shareButton.isEnabled = false
    }
    
    
    // Prsent the ActivityViewController, with adjustments for iPad that sometimes uses popovers:
    @IBAction func showSharingOptions(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // In order to work on iPad too, I had to add the following if/then code since iPads use popovers sometimes:
        if UIDevice.current.userInterfaceIdiom == .pad {
            controller.modalPresentationStyle = .popover
            controller.popoverPresentationController!.delegate = self
            controller.popoverPresentationController!.barButtonItem = shareButton
        }
        /*
         I made reference to the following code in StackOverflow which I found
         very helpful here:
         https://stackoverflow.com/questions/28169192/uiactivityviewcontroller-completion-handler-returns-success-when-tweet-has-faile
         */
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) -> Void in
            if completed {
                self.save()
            }
        }
        present(controller, animated: true, completion: nil)
    }
}


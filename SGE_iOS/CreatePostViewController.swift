//
//  CreatePostViewController.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 17/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var groupPickerView: UIPickerView!
    let ArrayGroups = ["Grupo A", "Grupo B", "C", "F"]
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var toolBarBottomConst: NSLayoutConstraint!
    var writeFlag:Bool = false
    var toolbarBottomConstraintInitialValue: CGFloat?
    @IBOutlet weak var postTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.postTextView.delegate = self
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#dc9c03")
        self.tabBarController?.tabBar.isHidden = true
        self.toolbarBottomConstraintInitialValue = toolBarBottomConst.constant
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
    }
    
    @IBAction func importImageFromCamera(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.camera
            image.cameraCaptureMode = .photo
            image.modalPresentationStyle = .fullScreen
            image.allowsEditing = false
            self.present(image, animated: true, completion: nil)
        }
    }
    
    @IBAction func importImageFromLibrary(_ sender: UIBarButtonItem) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
            //after completed
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            photoImageView.contentMode = .scaleToFill
            photoImageView.image = image
        }
        else
        {
                //error message
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.postTextView.resignFirstResponder()
        self.toolBarBottomConst.constant = self.toolbarBottomConstraintInitialValue!
        self.view.layoutIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(!writeFlag){
            postTextView.text = ""
            writeFlag = true
        }
    }

    @objc func keyboardWillShow(_ notification: Notification){
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) { () -> Void in
            self.toolBarBottomConst.constant = keyboardFrame.size.height + 5
            self.view.layoutIfNeeded()
        }
    }


    func textViewDidEndEditing(_ textView: UITextView) {
        if(postTextView.text == ""){
            postTextView.text = "What's on your mind?"
            writeFlag = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ArrayGroups[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ArrayGroups.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

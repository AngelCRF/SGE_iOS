//
//  ShowPostViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 16/06/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class ShowPostViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var imagePostImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#dc9c03")
        commentTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    func hideKeyboard(){
        commentTextField.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboradWillChange(notification: Notification){
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name==Notification.Name.UIKeyboardWillShow || notification.name==Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height+115
        } else {
            view.frame.origin.y = +63
        }
        
    }
}

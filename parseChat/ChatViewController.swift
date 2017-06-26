//
//  ChatViewController.swift
//  parseChat
//
//  Created by Tyler Holloway on 6/26/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBAction func pressSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbuJuly2017")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("the message was saved")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("problem saving the message: \(error.localizedDescription)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

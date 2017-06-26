//
//  ChatViewController.swift
//  parseChat
//
//  Created by Tyler Holloway on 6/26/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    var messages: [PFObject] = []
    
    func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className: "Message_fbu2017")
        query.findObjectsInBackground { (chatMessages: [PFObject]?, error: Error?) in
            if let chatMessages = chatMessages {
                // do something with the array of object returned by the call
                self.messages = chatMessages
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func pressSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbu2017")
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
        tableView.dataSource = self
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let messageObject = messages[indexPath.row]
        let messageText = messageObject["text"] as! String
        print(messageText)
        cell.messageLabel.text = messageText
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
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

//
//  LoginViewController.swift
//  parseChat
//
//  Created by Tyler Holloway on 6/26/17.
//  Copyright © 2017 Tyler Holloway. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //creates action for signup
    @IBAction func pressSignUp(_ sender: Any) {
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Username and Password Required", message: "Please enter a username and password.", preferredStyle: .alert)
            
            // create a cancel action
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert cont
            alertController.addAction(OKAction)
            
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        
        
        // initialize a user object
        let newUser = PFUser()
        
        
        // set user properties
        newUser.username = userNameTextField.text
        newUser.password = passwordTextField.text
    
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
        
    }
    
    
    //creates action for login
    @IBAction func pressLogin(_ sender: Any) {
        
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Username and Password Required", message: "Please enter a username and password.", preferredStyle: .alert)
            
            // create a cancel action
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert cont
            alertController.addAction(OKAction)
            
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        

        //if nill set to default, which is an empty string
        let username = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                //ADDED performSegue method
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
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

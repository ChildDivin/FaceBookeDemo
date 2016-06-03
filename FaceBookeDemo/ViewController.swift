//
//  ViewController.swift
//  FaceBookeDemo
//
//  Created by Tops on 6/3/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class ViewController: UIViewController ,FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                //self.returnUserData()
                self.sharePostUser()
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")

            }
        })
    }

    func sharePostUser(){
        
        if FBSDKAccessToken.currentAccessToken().hasGranted("publish_actions") {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/feed", parameters:["message": "hello world"],HTTPMethod: "POST")
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil) {
                   print(result)
                }
            })

        }
    }
}


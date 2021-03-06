//
//  AppDelegate.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 21/03/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, EILIndoorLocationManagerDelegate  {
    var window: UIWindow?
    let beaconManager = ESTBeaconManager()
    let locationManager = EILIndoorLocationManager()
    var location: EILLocation!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.locationManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        ESTConfig.setupAppID("bloom-app-b5e", andAppToken: "5aa7f32974cec8b8fa5e900f2d01ebbe")
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier: "bloom-lab-at-st-cats")
        fetchLocationRequest.sendRequestWithCompletion { (location, error) in
            if location != nil {
                self.location = location!
                self.locationManager.startMonitoringForLocation(self.location)
                self.locationManager.startPositionUpdatesForLocation(self.location)
                print(self.location)
            } else {
                print("Can't fetch location: \(error)")
            }
        }
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func indoorLocationManager(manager: EILIndoorLocationManager,
                               didFailToUpdatePositionWithError error: NSError) {
        print("Failed to update position: \(error)")
    }
    
    func indoorLocationManager(manager: EILIndoorLocationManager,
                               didUpdatePosition position: EILOrientedPoint,
                                                 withAccuracy positionAccuracy: EILPositionAccuracy,
                                                              inLocation location: EILLocation) {
        var accuracy: String!
        switch positionAccuracy {
        case .VeryHigh: accuracy = "+/- 1.00m"
        case .High:     accuracy = "+/- 1.62m"
        case .Medium:   accuracy = "+/- 2.62m"
        case .Low:      accuracy = "+/- 4.24m"
        case .VeryLow:  accuracy = "+/- ? :-("
        case .Unknown:  accuracy = "unknown"
        }
        print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f, accuracy: %@",
            position.x, position.y, position.orientation, accuracy))
    }
    
    func application(application: UIApplication,
                      openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            let login = self.window?.rootViewController as! BloomLoginViewController
            login.onGoogleLogin(signIn, user: user)
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


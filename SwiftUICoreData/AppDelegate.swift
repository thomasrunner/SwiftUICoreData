//
//  AppDelegate.swift
//  SwiftUICoreData
//
//  Created by Thomas on 2020-07-02.
//  Copyright © 2020 Thomas Lock. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var coreData : CoreDataStack = {
        let stack = CoreDataStack()
        return stack
    }()
    
    func managedContext() -> NSManagedObjectContext {
        var context:NSManagedObjectContext
        
        context = (coreData.persistentContainer.viewContext)
        return context;
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadPreloadedStocks()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    let preLoadedStocks = ["AACG" : "ATA Creativity Global - American Depositary Shares", "AAL" : "American Airlines Group, Inc. - Common Stock", "AAME": "Atlantic American Corporation - Common Stock", "AAOI": "Applied Optoelectronics, Inc. - Common Stock", "AAON": "AAON, Inc. - Common Stock", "AAPL": "Apple Inc. - Common Stock", "AAWW": "Atlas Air Worldwide Holdings - Common Stock", "AAXJ": "iShares MSCI All Country Asia ex Japan Index Fund"]
    
    func loadPreloadedStocks() {
        
        if !UserDefaults.standard.bool(forKey: "demo") {
            UserDefaults.standard.set(true, forKey: "demo")
            
            let context = managedContext()
            
            for stocks in preLoadedStocks.keys {
                let stock = Stock(entity: Stock.entity(), insertInto: context)
                stock.symbol = stocks
                stock.name = preLoadedStocks[stocks] ?? ""
            }
            
            coreData.saveContext()
            
        }
    }
}


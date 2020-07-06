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

    // This provides a universal way of accessing the core data stack.
    lazy var coreData : CoreDataStack = {
        let stack = CoreDataStack()
        return stack
    }()
    
    // This provides a universal way of accessing the managed context.
    func managedContext() -> NSManagedObjectContext {
        var context:NSManagedObjectContext
        
        context = (coreData.persistentContainer.viewContext)
        return context;
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.loadPreloadedStocks()
        self.setupColorAppearance()
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

    // List of sample stocks
    let preLoadedStocks = ["AACG" : "ATA Creativity Global - American Depositary Shares", "AAL" : "American Airlines Group, Inc. - Common Stock", "AAME": "Atlantic American Corporation - Common Stock", "AAOI": "Applied Optoelectronics, Inc. - Common Stock", "AAON": "AAON, Inc. - Common Stock", "AAPL": "Apple Inc. - Common Stock", "AAWW": "Atlas Air Worldwide Holdings - Common Stock", "AAXJ": "iShares MSCI All Country Asia ex Japan Index Fund"]
    
    // Loads the sample stocks once into presistent container/ database.
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
    
    fileprivate func setupColorAppearance() {
        let coloredNavAppearance = UINavigationBarAppearance()
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor.init(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
}


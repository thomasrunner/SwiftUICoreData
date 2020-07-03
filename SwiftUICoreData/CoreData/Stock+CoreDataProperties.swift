//
//  Stock+CoreDataProperties.swift
//  SwiftUICoreData
//
//  Created by Thomas on 2020-07-02.
//  Copyright © 2020 Thomas Lock. All rights reserved.
//
//

import Foundation
import CoreData


extension Stock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbol: String?

}

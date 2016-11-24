//
//  Commit+CoreDataProperties.swift
//  GitHubCommits
//
//  Created by David Petrofsky on 11/23/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit");
    }

    @NSManaged public var date: Date
    @NSManaged public var message: String
    @NSManaged public var sha: String
    @NSManaged public var url: String
    @NSManaged public var author: Author

}

//
//  Contact+CoreDataProperties.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var birthYear: Int32
    @NSManaged public var birthMonth: Int32

}

extension Contact : Identifiable {

}

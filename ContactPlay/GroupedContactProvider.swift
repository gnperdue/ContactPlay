//
//  ContactProvider.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import CoreData
import SwiftUI

class GroupedContactProvider: ObservableObject {

  @Published var contacts: [String: Contact] = [:]
  private var context: NSManagedObjectContext?
  private let sortByNameDescriptors = [
    NSSortDescriptor(keyPath: \Contact.lastName, ascending: true),
    NSSortDescriptor(keyPath: \Contact.firstName, ascending: true)
  ]

  public func setContext(_ context: NSManagedObjectContext) {
    self.context = context
  }
  
  public func reFetch() {
    guard let context = context else { return }
    let fetchRequest: NSFetchRequest = Contact.fetchRequest()
    fetchRequest.sortDescriptors = sortByNameDescriptors
    do {
      let contactsArray = try context.fetch(fetchRequest)
      // loop over array and get first letter of last name,
      // add to dict -- everything is already sorted, so we only need to look
      // for new first letters in the last name
    } catch let error as NSError {
      print("fetch error: \(error), \(error.userInfo)")
    }
  }
  
}

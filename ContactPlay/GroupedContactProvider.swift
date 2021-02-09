//
//  ContactProvider.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import CoreData
import SwiftUI


class GroupedContactProvider: ObservableObject {

  @Published var contacts: [Character: [Contact]] = [:]
  @Published var letters: [Character] = []
  private var context: NSManagedObjectContext?
  private let sortByNameDescriptors = [
    NSSortDescriptor(keyPath: \Contact.lastName, ascending: true),
    NSSortDescriptor(keyPath: \Contact.firstName, ascending: true)
  ]
  private let allLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

  public func setContext(_ context: NSManagedObjectContext) {
    self.context = context
  }
  
  public func reFetch() {
    guard let context = context else { return }
    let fetchRequest: NSFetchRequest = Contact.fetchRequest()
    fetchRequest.sortDescriptors = sortByNameDescriptors
    do {
      letters = []
      let contactsArray = try context.fetch(fetchRequest)
      for contact in contactsArray {
        if let firstLetterOfLastName = contact.lastName?.first {
          if !contacts.keys.contains(firstLetterOfLastName) {
            contacts[firstLetterOfLastName] = []
            letters.append(firstLetterOfLastName)
          }
          contacts[firstLetterOfLastName]?.append(contact)
        }
      }
    } catch let error as NSError {
      print("fetch error: \(error), \(error.userInfo)")
    }
  }
}

// ACTUALLY -- can add a properties to group by and set the .resultType
// to .DictionaryResultType ???
// see: https://developer.apple.com/forums/thread/129689
// see: https://stackoverflow.com/questions/31935618/group-by-in-core-data-in-ios-swift-not-working
// -- seems to just segfault...

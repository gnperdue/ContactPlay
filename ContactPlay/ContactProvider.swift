//
//  ContactProvider.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import CoreData
import SwiftUI

class ContactProvider: ObservableObject {

  @Published var contacts: [Contact] = []
  @Published var sortByName: Bool = true
  private var context: NSManagedObjectContext?
  private let sortByNameDescriptors = [
    NSSortDescriptor(keyPath: \Contact.lastName, ascending: true),
    NSSortDescriptor(keyPath: \Contact.firstName, ascending: true)
  ]
  private let sortByDateDescriptors = [
    NSSortDescriptor(keyPath: \Contact.birthYear, ascending: true),
    NSSortDescriptor(keyPath: \Contact.birthMonth, ascending: true)
  ]
  
  public func toggle() {
    self.sortByName.toggle()
    reFetch()
  }

  public func setContext(_ context: NSManagedObjectContext) {
    self.context = context
  }
  
  public func reFetch() {
    guard let context = context else { return }
    let fetchRequest: NSFetchRequest = Contact.fetchRequest()
    fetchRequest.sortDescriptors =
      sortByName ? sortByNameDescriptors : sortByDateDescriptors
    do {
      self.contacts = try context.fetch(fetchRequest)
    } catch let error as NSError {
      print("fetch error: \(error), \(error.userInfo)")
    }
  }
  
}

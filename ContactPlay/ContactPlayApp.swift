//
//  ContactPlayApp.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import SwiftUI
import CoreData

@main
struct ContactPlayApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
  
  init() {
    importJSONSeedDataIfNeeded()
  }
  
  func importJSONSeedDataIfNeeded() {
    let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
    let count = try? persistenceController.container.viewContext.count(for: fetchRequest)
    guard let contactCount = count, contactCount == 0 else {
      return
    }

    importJSONSeedData()
  }

  func importJSONSeedData() {
    let jsonURL = Bundle.main.url(forResource: "seed", withExtension: "json")!
    let jsonData = try! Data(contentsOf: jsonURL)
    do {
      let jsonArray = try JSONSerialization.jsonObject(
        with: jsonData, options: [.allowFragments]) as! [[String: Any]]
      for jsonDictionary in jsonArray {
        let firstName = jsonDictionary["firstName"] as! String
        let lastName = jsonDictionary["lastName"] as! String
        let birthMonth = jsonDictionary["birthMonth"] as! Int32
        let birthYear = jsonDictionary["birthYear"] as! Int32
        
        let contact = Contact(
          context: persistenceController.container.viewContext)
        contact.firstName = firstName
        contact.lastName = lastName
        contact.birthMonth = birthMonth
        contact.birthYear = birthYear
        try persistenceController.container.viewContext.save()
      }
    } catch let error as NSError {
      print("Seed import error: \(error)")
    }
  }
}

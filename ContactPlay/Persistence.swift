//
//  Persistence.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext

    let newContact1 = Contact(context: viewContext)
    newContact1.lastName = "Appleseed"
    newContact1.firstName = "John"
    newContact1.birthYear = Int32(1985)
    newContact1.birthMonth = Int32(9)

    let newContact2 = Contact(context: viewContext)
    newContact2.lastName = "Zoolander"
    newContact2.firstName = "Jane"
    newContact2.birthYear = Int32(1977)
    newContact2.birthMonth = Int32(6)

    let newContact3 = Contact(context: viewContext)
    newContact3.lastName = "Appleseed"
    newContact3.firstName = "Jane"
    newContact3.birthYear = Int32(1990)
    newContact3.birthMonth = Int32(1)

    do {
      try viewContext.save()
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "ContactPlay")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
  }
}

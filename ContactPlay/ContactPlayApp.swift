//
//  ContactPlayApp.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import SwiftUI

@main
struct ContactPlayApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}

//
//  ContentView.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Contact.lastName, ascending: true)],
    animation: .default)
  private var contacts: FetchedResults<Contact>
  
  var body: some View {
    List {
      ForEach(contacts) { contact in
        Text("\(contact.lastName!), \(contact.firstName!): " +
              "\(contact.birthMonth)/\(contact.birthYear)")
      }
    }
  }
  
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}

//
//  SimpleSortingChoiceView.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import SwiftUI

struct SimpleSortingChoiceView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @State private var sortByName = true
  
  let sortByNameDescriptors = [
    NSSortDescriptor(keyPath: \Contact.lastName, ascending: true),
    NSSortDescriptor(keyPath: \Contact.firstName, ascending: true)
  ]
  let sortByDateDescriptors = [
    NSSortDescriptor(keyPath: \Contact.birthYear, ascending: true),
    NSSortDescriptor(keyPath: \Contact.birthMonth, ascending: true)
  ]

  @FetchRequest(
    sortDescriptors: sortByName ? sortByNameDescriptors : sortByDateDescriptors,
    animation: .default)
  private var contacts: FetchedResults<Contact>
  
  var body: some View {
    VStack {
      Button(action: {
        sortByName.toggle()
      }, label: {
        if sortByName {
          Text("Sort by date")
        } else {
          Text("Sort by name")
        }
      })
      List {
        ForEach(contacts) { contact in
          Text("\(contact.lastName!), \(contact.firstName!): " +
                "\(contact.birthMonth)/\(contact.birthYear)")
        }
      }
    }
  }
}

struct SimpleSortingChoiceView_Previews: PreviewProvider {
  static var previews: some View {
    SimpleSortingChoiceView()
      .environment(\.managedObjectContext,
                   PersistenceController.preview.container.viewContext)
  }
}

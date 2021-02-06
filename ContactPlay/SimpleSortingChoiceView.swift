//
//  SimpleSortingChoiceView.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import SwiftUI

struct SimpleSortingChoiceView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @StateObject var contactProvider = ContactProvider()
  
  var body: some View {
    VStack {
      Button(action: {
        contactProvider.toggle()
      }, label: {
        if contactProvider.sortByName {
          Text("Sort by date")
        } else {
          Text("Sort by name")
        }
      })
      List {
        ForEach(contactProvider.contacts) { contact in
          Text("\(contact.lastName!), \(contact.firstName!): " +
                "\(contact.birthMonth)/\(contact.birthYear)")
        }
      }
    }
    .onAppear {
      contactProvider.setContext(viewContext)
      contactProvider.reFetch()
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

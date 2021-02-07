//
//  GroupedContactsView.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import SwiftUI

struct GroupedContactsView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @StateObject var contactProvider = GroupedContactProvider()

  var body: some View {
    VStack {
      List {
        ForEach(contactProvider.letters, id: \.self) { letter in
          Section(header: Text(String(letter))) {
            ForEach(contactProvider.contacts[letter]!, id: \.self) { contact in
              Text("\(contact.lastName!), \(contact.firstName!)")
            }
          }
        }
      }
    }
    .onAppear {
      contactProvider.setContext(viewContext)
      contactProvider.reFetch()
    }
  }
}

struct GroupedContactsView_Previews: PreviewProvider {
  static var previews: some View {
    GroupedContactsView()
      .environment(\.managedObjectContext,
                   PersistenceController.preview.container.viewContext)
  }
}

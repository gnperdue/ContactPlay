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
  @State var sectionState: [Character: Bool] = [:]

  var body: some View {
    VStack {
      List {
        ForEach(contactProvider.letters, id: \.self) { letter in
          Section(header: Label(String(letter), systemImage: (sectionState[letter] ?? false) ? "arrow.down" : "arrow.right") .onTapGesture {
            sectionState[letter] = !isExpanded(letter)
          }) {
            if isExpanded(letter) {
              ForEach(contactProvider.contacts[letter]!, id: \.self) { contact in
                Text("\(contact.lastName!), \(contact.firstName!)")
              }
            }
          }
        }
      }
      .listStyle(GroupedListStyle())
    }
    .onAppear {
      contactProvider.setContext(viewContext)
      contactProvider.reFetch()
    }
  }
  
  func isExpanded(_ letter: Character) -> Bool {
    sectionState[letter] ?? false
  }
}

struct GroupedContactsView_Previews: PreviewProvider {
  static var previews: some View {
    GroupedContactsView()
      .environment(\.managedObjectContext,
                   PersistenceController.preview.container.viewContext)
  }
}

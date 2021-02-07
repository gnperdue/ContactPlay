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
      // need tp iterate over dict and make a section for each key,
      // then a list within each section of the contacts belonging to it
//      List {
//        ForEach(contactProvider.contacts.keys, id: \.self) { key in
//          
//        }
//      }
      Text("mellow")
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
  }
}

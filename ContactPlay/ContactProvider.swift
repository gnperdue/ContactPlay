//
//  ContactProvider.swift
//  ContactPlay
//
//  Created by Gabriel Perdue on 2/6/21.
//

import SwiftUI

class ContactProvider: ObservableObject {

  @Published var contacts: [Contact] = []
  
  let sortByNameDescriptors = [
    NSSortDescriptor(keyPath: \Contact.lastName, ascending: true),
    NSSortDescriptor(keyPath: \Contact.firstName, ascending: true)
  ]
  let sortByDateDescriptors = [
    NSSortDescriptor(keyPath: \Contact.birthYear, ascending: true),
    NSSortDescriptor(keyPath: \Contact.birthMonth, ascending: true)
  ]

}

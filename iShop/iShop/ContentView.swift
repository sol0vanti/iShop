//
//  ContentView.swift
//  iShop
//
//  Created by Alex Balla on 05.04.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var emailAddress: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $emailAddress)
                    .textFieldStyle(.roundedBorder)
                    .font(.headline)
                    .padding(.horizontal, 25)
                
                Button{
                    
                } label: {
                    Label("Sign in or sign up", systemImage: "shield.lefthalf.filled")
                        .frame(maxWidth: .infinity)
                        .frame(height: 25)
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 25)
                .padding(.vertical, 15)
                //            ============ Nav Bar Styles  ============
                .navigationTitle("iShop")
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

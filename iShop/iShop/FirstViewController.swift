//
//  ContentView.swift
//  iShop
//
//  Created by Alex Balla on 05.04.2025.
//

import SwiftUI
import CoreData
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct CreateAccountViewController: View {
    var body: some View {
        Text("Don't have an account?")
    }
}

struct FirstViewController: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var emailAddress: String = ""
    @State private var emailPassword: String = ""
    @State private var isButtonClicked: Bool = false
    @State var path = NavigationPath()


    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextField("Email", text: $emailAddress)
                    .textFieldStyle(.roundedBorder)
                    .font(.headline)
                    .padding(.horizontal, 25)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $emailPassword)
                    .textFieldStyle(.roundedBorder)
                    .font(.headline)
                    .padding(.horizontal, 25)
                    .padding(.top, 15)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                Text("The following text fields should be filled.")
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .opacity(isButtonClicked ? 1 : 0)
                    .padding(.top, 15)
                
                Button{
                    guard emailAddress != "" && emailPassword != "" else {
                        isButtonClicked = true
                        print("clicked")
                        return
                    }
                    Auth.auth().signIn(withEmail: emailAddress, password: emailPassword) { authResult, error in
                        if error != nil {
                            print(String(describing: error))
                            path.append(1)
                        }
                        
                    }
                } label: {
                    Label("Sign in or sign up", systemImage: "shield.lefthalf.filled")
                        .frame(maxWidth: .infinity)
                        .frame(height: 25)
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 25)
                .navigationDestination(for: Int.self) { _ in
                    CreateAccountViewController()
                }
                //            ============ Nav Bar Styles  ============
                .navigationTitle("iShop")
            }
        }
    }
}


#Preview {
    FirstViewController().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

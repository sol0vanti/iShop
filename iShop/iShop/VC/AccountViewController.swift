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
    @Environment(\.managedObjectContext) private var viewContext
    var email: String
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorText: String = ""
    @State private var isButtonClicked: Bool = false
    
    var body: some View {
        VStack {
            Text(email)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .font(.headline)
                .padding(.horizontal, 25)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
                .font(.headline)
                .padding(.horizontal, 25)
                .padding(.top, 15)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
            Text(errorText)
                .fontWeight(.bold)
                .foregroundColor(Color.red)
                .opacity(isButtonClicked ? 1 : 0)
                .padding(.top, 15)
                
            Button{
                
            } label: {
                Label("Create new account", systemImage: "person.circle.fill")
                    .frame(maxWidth: .infinity)
                    .frame(height: 25)
                    .font(.headline)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 25)
        }
        .navigationTitle("Don't have an account?")
    }
}

struct MainViewController: View {
    var body: some View {
        Text("Hello Byden")
    }
}

enum VCToPresent: Hashable {
    case signup
    case login
}

struct AccountViewController: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var emailAddress: String = ""
    @State private var emailPassword: String = ""
    @State private var isButtonClicked: Bool = false
    @State private var errorText: String = ""
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
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
                
                Text(errorText)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .opacity(isButtonClicked ? 1 : 0)
                    .padding(.top, 15)
                
                Button{
                    guard emailAddress != "" && emailPassword != "" else {
                        errorText = "The following text fields should be filled."
                        isButtonClicked = true
                        print("clicked")
                        return
                    }
                    Auth.auth().signIn(withEmail: emailAddress, password: emailPassword) { authResult, error in
                        if error != nil {
                            print(String(describing: error))
                            navigationPath.append(VCToPresent.signup)
                        } else {
                            navigationPath.append(VCToPresent.login)
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
                .navigationDestination(for: VCToPresent.self) { destination in
                    switch destination {
                    case .login:
                        MainViewController()
                    case .signup:
                        CreateAccountViewController(email: emailAddress)
                    }
                }
                //            ============ Nav Bar Styles  ============
                .navigationTitle("iShop")
            }
        }
    }
}


#Preview {
    AccountViewController().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

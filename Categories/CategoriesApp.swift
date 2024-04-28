//
//  CategoriesApp.swift
//  Categories
//
//  Created by Nouf Faisal  on 16/10/1445 AH.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CategoriesApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var firebaseManger =  FirebaseManger()

    var body: some Scene {
    WindowGroup {
      NavigationView {
          ContentView()
              .environmentObject(firebaseManger)
      }
    }
  }
}

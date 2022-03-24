//
//  AYS_Watch_SwiftUIApp.swift
//  AYS_Watch_SwiftUI WatchKit Extension
//
//  Created by Valentin Kovalski on 23/03/2022.
//

import SwiftUI
import Firebase

@main
struct AYS_Watch_SwiftUIApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

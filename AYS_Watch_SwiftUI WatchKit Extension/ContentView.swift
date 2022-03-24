//
//  ContentView.swift
//  AYS_Watch_SwiftUI WatchKit Extension
//
//  Created by Valentin Kovalski on 23/03/2022.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    @ObservedObject var messageManager = MessageManager()
    @State private var showingAlert = true
    
    var body: some View {
        VStack {
            Text(messageManager.message != AYSIdleText ?
                 messageManager.message + " is answering" :
                    messageManager.message)
              .padding().onAppear {
                messageManager.startMessageListener()
              }.onDisappear {
                messageManager.stopMessageListener()
              }
            if messageManager.message != AYSIdleText {
                
                Button("Good answer") {
                    resetAswers(true)
                }
                Button("Skip") {
                    resetAswers(false)
                }
            }
        }
        
      }
    
    func resetAswers(_ goodAnswer: Bool) {
        Database.database().reference().ref.child("/Students").child(messageManager.message).setValue(["toBeEvaluated": false])
        
        let latestMessage = goodAnswer ? "Good answer registered" : "Skipped"
        Database.database().reference().ref.child("/Students").child("latestMessage").setValue(messageManager.message + " - " + latestMessage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

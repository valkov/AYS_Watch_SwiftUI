//
//  MessageManager.swift
//  AYS_Watch_SwiftUI WatchKit Extension
//
//  Created by Valentin Kovalski on 23/03/2022.
//

import Foundation
import FirebaseDatabase

let AYSIdleText = "AYS waiting for student"

class MessageManager: ObservableObject {
  @Published var message = AYSIdleText
  lazy var studentsRef: DatabaseReference = Database.database().reference().ref.child("/Students")
  var messageHandle: DatabaseHandle?
  
  func startMessageListener() {
    messageHandle = studentsRef.observe(.value, with: { snapshot in
        self.message = AYSIdleText

      if let dic = snapshot.value as? Dictionary<String, Any> {
          for name in dic.keys {
              if let nameDic = dic[name] as? Dictionary<String, Bool>, let toBeEvaluated = nameDic["toBeEvaluated"] {
                  if toBeEvaluated {
                      self.message = name
                  }
              }
                  
          }
      }
    })
  }
  
  func stopMessageListener() {
    if messageHandle != nil {
        studentsRef.removeObserver(withHandle: messageHandle!)
    }
  }
}

//
//  NotificationViewModel.swift
//  SwiftUICombineAndData
//
//  Created by Brenda Saavedra  on 20/04/23.
//

import SwiftUI
import UserNotifications
import FirebaseMessaging

class NotificationViewModel: ObservableObject {
    @Published var permission: UNAuthorizationStatus?
    @AppStorage("subscribedToAllNotifications") var subscribedToAllNotifications: Bool = false {
        didSet {
            if subscribedToAllNotifications {
                subscribeToAllTopics()
            } else {
                unsubscribeFromAllTopics()
            }
        }
    }
    
    // Listen to device's notification settings
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings() { permission in
            DispatchQueue.main.async {
                self.permission = permission.authorizationStatus
            }
            
            if permission.authorizationStatus == .authorized {
                // Authorized to send notifications
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
                if self.subscribedToAllNotifications {
                    self.subscribeToAllTopics()
                } else {
                    self.unsubscribeFromAllTopics()
                }
            } else {
                // Unauthorized to send notifications
                DispatchQueue.main.async {
                    UIApplication.shared.unregisterForRemoteNotifications()
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                }
                self.unsubscribeFromAllTopics()
            }
        }
    }
    
    private func subscribeToAllTopics() {
        guard permission == .authorized else { return }
        
        Messaging.messaging().subscribe(toTopic: "all") { error in
            if let error = error {
                #if DEBUG
                print("Error while subscribing: ", error)
                #endif
                return
            }
            #if DEBUG
            print("Subscribed to notifications for all topics")
            #endif
        }
    }
    
    private func unsubscribeFromAllTopics() {
        Messaging.messaging().unsubscribe(fromTopic: "all") { error in
            if let error = error {
                #if DEBUG
                print("Error while unsubscribing: ", error)
                #endif
                return
            }
            #if DEBUG
            print("Unsubscribed from notifications for all topics")
            #endif
        }
    }
    
}

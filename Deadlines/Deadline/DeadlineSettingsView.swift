//
//  DeadlineView.swift
//  Deadlines
//
//  Created by Jack Devey on 09/01/2023.
//

import SwiftUI

struct DeadlineSettingsView: View {
    
    // View context for CoreData
    @Environment(\.managedObjectContext) private var viewContext
    
    // Deadline to show settings for
    @ObservedObject var deadline: Item
    
    // Alert vars
    @State var isShowingResetAlert = false
    
    var body: some View {
        List {
            // Edit deadline submission status
            HStack {
                Text("Submitted")
                    .font(.headline)
                Spacer()
                Toggle("", isOn: $deadline.submitted)
            }.padding([.leading, .trailing], 5)
            // Options
            Section(header: Text("Options")) {
                // Reset button
                MYNavigationLink {
                    // Show the reset alert
                    isShowingResetAlert = true
                } label: {
                    NiceIconLabel(text: "Reset Progress", color: .blue, iconName: "arrow.rectanglepath")
                }
            }
        }
        // Reset deadline
        .alert("Are you sure you want to reset this Deadlines progress?", isPresented: $isShowingResetAlert) {
            // Yes
            Button("Yes", role: .destructive) {
                // Reset progress from deadline
                deadline.removeFromTodos(deadline.todos!)
                try? viewContext.save()
            }
            // Cancel
            Button("Cancel", role: .cancel) {
                
            }
        }
        // Set title
        .navigationTitle("Settings")
    }
}

struct MYNavigationLink<Label: View>: View {
  
  @Environment(\.colorScheme) var colorScheme
  
  private let action: () -> Void
  private let label: () -> Label
  
  init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
    self.action = action
    self.label = label
  }
  
  var body: some View {
    Button(action: action) {
      HStack(spacing: 0) {
        label()
        Spacer()
        NavigationLink.empty
          .layoutPriority(-1) // prioritize `label`
      }
    }
    // Fix the `tint` color that `Button` adds
    .tint(colorScheme == .dark ? .white : .black) // TODO: Change this for your app
  }
}

// Inspiration:
// - https://stackoverflow.com/a/66891173/826435
private extension NavigationLink where Label == EmptyView, Destination == EmptyView {
   static var empty: NavigationLink {
       self.init(destination: EmptyView(), label: { EmptyView() })
   }
}

////
////  NewDeadline.swift
////  Deadlines
////
////  Created by Jack Devey on 25/12/2022.
////
//
//import SwiftUI
//
//struct NewDeadline: View {
//    
//    @Environment(\.dismiss) private var dismiss
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @State private var name: String = ""
//    @State private var color: Color = .darkGray
//    @State private var iconName: String = "bookmark.fill"
//    @State private var date: Date = Date() + 1
//    
//    let deadlineCustomisations = DeadlineCustomisations()
//    
//    let columns = [
//        GridItem(.adaptive(minimum: 40))
//    ]
//    
//    var body: some View {
//        NavigationView {
//            List {
//                Section(header: Text("Preview")) {
//                    HStack(alignment: .top) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 7)
//                                .fill(color)
//                                .frame(width: 40, height: 40)
//                            Image(systemName: iconName)
//                                .foregroundColor(.white)
//                        }
//                        VStack(alignment: .leading) {
//                            // Deadline name
//                            Text(name != "" ? name : "Unnamed")
//                                .font(.headline)
//                            // Deadline due
//                            Text(date, style: .date)
//                                .foregroundColor(.secondary)
//                            //                            // Deadline tags
//                            //                            if self.tags?.count != 0 {
//                            //                                Text(self.tagNames.joined(separator: " "))
//                            //                                    .font(.system(.subheadline, design: .rounded))
//                            //                                    .foregroundColor(.systemIndigo)
//                            //                                    .bold()
//                            //                            }
//                        }
//                        .padding([.leading], 5)
//                    }
//                    .padding(5)
//                }
//                Section {
//                    TextField("Name", text: $name)
//                    DatePicker("Due Date", selection: $date, in: Date.now...)
//                }
//                Section() {
//                    // Show all available colours
//                    LazyVGrid(columns: columns, spacing: 20) {
//                        ForEach(deadlineCustomisations.colours, id: \.self) { lColor in
//                            ZStack {
//                                Circle()
//                                    .fill(lColor)
//                                    .frame(width: 40, height: 40)
//                                if lColor == color {
//                                    Image(systemName: "checkmark")
//                                }
//                            }
//                            .onPress {
//                                color = lColor
//                            }
//                        }
//                    }
//                    
//                }
//                Section() {
//                    // Show all available icons
//                    LazyVGrid(columns: columns, spacing: 20) {
//                        ForEach(deadlineCustomisations.icons, id: \.self) { icon in
//                            ZStack {
//                                if iconName == icon {
//                                    Circle()
//                                        .fill(Color.accentColor)
//                                        .frame(width: 40, height: 40)
//                                } else {
//                                    Circle()
//                                        .fill(Color.darkGray)
//                                        .frame(width: 40, height: 40)
//                                }
//                                Image(systemName: icon)
//                            }
//                            .onPress {
//                                iconName = icon
//                            }
//                        }
//                    }
//                }
//                
//            }
//            .navigationTitle("New deadline")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(id: "cancel", placement: .cancellationAction) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Text("Cancel")
//                    }
//                }
//                ToolbarItem(id: "create", placement: .confirmationAction) {
//                    Button {
//                                                let link = Item(context: viewContext)
//                                                link.id = UUID()
//                                                link.name = $name.wrappedValue
//                                                link.date = $date.wrappedValue
//                                                link.color = Int16(deadlineCustomisations.colours.firstIndex(of: color)!)
//                                                link.iconName = iconName
//                                                Store().save(viewContext: viewContext)
//                                                NotificationsManager().scheduleDeadlineNotifications(deadline: link)
//                                                dismiss()
//                    } label: {
//                        Text("Create")
//                    }
//                }
//            }
//        }
//    }
//}
//
//

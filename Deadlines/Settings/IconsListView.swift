////
////  IconsListView.swift
////  Deadlines
////
////  Created by Jack Devey on 10/01/2023.
////
//
//#if os(iOS)
//import SwiftUI
//
//struct IconsListView: View {
//    
//    @State var iconName: String? = UIApplication.shared.alternateIconName
//    
//    var body: some View {
//        List {
//            // Default icon
//            IconRow(IconsManager.Icon(name: "Default", iconName: nil, image: UIImage(named: "IconDefault"), desc: "Just the normal icon"))
//            // Flat icon
//            IconRow(IconsManager.Icon(name: "Flat", iconName: "Flat", image: UIImage(named: "IconFlat"), desc: "Like normal but flat"))
//            
//            // Other apps
//            Section(header: "Other Apps") {
//                // Flat icon
//                IconRow(IconsManager.Icon(name: "Aside", iconName: "Aside", image: UIImage(named: "IconAside"), desc: "Your favourite money manager"))
//                // Emoji icon
//                IconRow(IconsManager.Icon(name: "Macros", iconName: "Macros", image: UIImage(named: "IconMacros"), desc: "Its not even out yet"))
//            }
//            
//            // Other apps
//            Section(header: "Special") {
//                // Flat icon
//                IconRow(IconsManager.Icon(name: "Black", iconName: "Black", image: UIImage(named: "IconBlack"), desc: "You're a professional"))
//                // Flat icon
//                IconRow(IconsManager.Icon(name: "White", iconName: "White", image: UIImage(named: "IconWhite"), desc: "For fans of light mode"))
//                // Emoji icon
//                IconRow(IconsManager.Icon(name: "Emoji", iconName: "Emoji", image: UIImage(named: "IconEmoji"), desc: "Idk why you like this"))
//            }
//        }
//        // Set title
//        .navigationTitle("App Icon")
//
////            // On icon picked
////            .onChange(of: iconsManager.index) { idx in
////                // If app supports alternate icons
////                guard UIApplication.shared.supportsAlternateIcons else {
////                    print("App does not support alternate icons")
////                    return
////                }
////                // Get current index
////                let old = iconsManager.icons.firstIndex(where: { icon in
////                    return icon.iconName == iconsManager.currentIconName
////                }) ?? 0
////                // If new index is old (no change)
////                guard idx != old else {
////                    return
////                }
////                // Set new icon
////                let selection = iconsManager.icons[idx].iconName
////                UIApplication.shared.setAlternateIconName(selection) { error in
////                    // If error, print error
////                    if let error = error {
////                        print(error.localizedDescription)
////                    }
////                }
////            }
//        
//    }
//    
//    @ViewBuilder
//    func IconRow(_ icon: IconsManager.Icon) -> some View {
//        Button{
//            // If app supports alt icons
//            guard UIApplication.shared.supportsAlternateIcons else {
//                print("App does not support alternate icons")
//                return
//            }
//            // If new name is old (no change)
//            guard icon.iconName != iconName else {
//                return
//            }
//            // Set new icon
//            iconName = icon.iconName
//            UIApplication.shared.setAlternateIconName(iconName) { error in
//                // If error, print error
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//        } label: {
//            // Show each link as a link (with label)
//            HStack {
//                HStack(alignment: .center) {
//                    // Link image
//                    Image(uiImage: icon.image ?? UIImage())
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .cornerRadius(7)
//                    // Name & URL
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text(icon.name)
//                            .bold()
//                        Text(icon.desc)
//                            .foregroundColor(.secondaryLabel)
//                    }
//                    .padding([.leading], 5)
//                }
//                .padding(5)
//                Spacer()
//                if iconName == icon.iconName {
//                    Image(systemName: "checkmark.circle.fill")
//                        .foregroundColor(.green)
//                }
//            }
//            .tint(.primary)
//        }
//    }
//}
//#endif

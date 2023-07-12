////
////  CreditsView.swift
////  Deadlines
////
////  Created by Jack Devey on 22/01/2023.
////
//
//import SwiftUI
//import CoreMotion
//
//
//struct CreditsView: View {
//        
//    var body: some View {
//        List {
//            Section {
//                // Licenses section
//                NavigationLink(destination: LicensesView()) {
//                    NiceIconLabel(text: "Licenses", color: .systemBrown, iconName: "doc")
//                }
//            }
//            Section {
//                NavigationLink {
//                    Image("bert")
//                        .resizable()
//                        .scaledToFill()
//                } label: {
//                    NiceIconLabel(text: "Bert", color: .blue, iconName: "pawprint.fill")
//                }
//            }
//        }
//        // Title
//        .navigationBarTitle("Acknowledgements")
//    }
//    
//    
//}
//
//struct AttributionRowView: View {
//    
//    var imageURL: URL
//    var name: String
//    var url: URL
//    
//    var body: some View {
//        HStack(alignment: .center) {
//            // Link image
//            AsyncImage(
//                url: imageURL,
//                transaction: Transaction(animation: .easeInOut)
//            ) { phase in
//                switch phase {
//                case .empty:
//                    ProgressView()
//                case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .transition(.scale(scale: 0.1, anchor: .center))
//                case .failure:
//                    Image(systemName: "person")
//                @unknown default:
//                    EmptyView()
//                }
//            }
//            .frame(width: 40, height: 40)
//            .backgroundFill(.secondarySystemFill)
//            .clipShape(RoundedRectangle(cornerRadius: 7))
//            
//            // Name & URL
//            VStack(alignment: .leading, spacing: 0) {
//                HStack {
//                    // Link name
//                    Text(name)
//                        .font(.headline)
//                    // Seen icon
//                         Image(systemName: "checkmark.seal")
//                             .foregroundColor(.green)
//                             .imageScale(.small)
//                }
//                // Link URL
//                Text(url.absoluteString)
//                    .lineLimit(1)
//                    .foregroundColor(.secondaryLabel)
//            }
//            .padding([.leading], 5)
//        }
//        .padding(5)
//    }
//    
//}

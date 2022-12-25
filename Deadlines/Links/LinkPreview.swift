//
//  LinkPreview.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct LinkPreview: View {
    
    @ObservedObject var item: Item
    
    var body: some View {
        
        NavigationLink("Edit links") {
            LinkEditor(item: item)
        }
        
    }
}

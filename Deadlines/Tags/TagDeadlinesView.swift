//
//  TagsListView.swift
//  Deadlines
//
//  Created by Jack Devey on 12/01/2023.
//

import SwiftUI

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}

struct TagDeadlinesView: View {
    
    var tag: Tag
    
    
    init(tag: Tag) {
            //Use this if NavigationBarTitle is with Large Font
            //UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]

            //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBarAppearance().largeTitleTextAttributes = [NSAttributedString.Key.font:UIFontDescriptor.SystemDesign.rounded]

        
        self.tag = tag
        }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("#\(tag.text ?? "Unknown")")
                .font(.system(.largeTitle, design: .rounded))
        }
    }
}


//
//  SystemSettingsHelper.swift
//  Deadlines
//
//  Created by Jack Devey on 12/07/2023.
//

import Foundation

struct SystemSettingsHelper {
    
    static func setAppInfo() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.setValue(version, forKey: "version")
    }
    
}

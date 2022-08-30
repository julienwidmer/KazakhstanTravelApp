//
//  UserDefaultsManager.swift
//  Travel KZH
//
//  Created by Julien Widmer on 2022-07-07.
//

import Foundation

extension UserDefaults {
    func saveRate(_ rate: Double?) {
        if let rate = rate {
            UserDefaults.standard.set(rate, forKey: "Rate")
        }
    }
    
    func getRate() -> Double? {
        UserDefaults.standard.double(forKey: "Rate")
    }
    
    func saveRateDate(_ date: String?) {
        if let date = date {
            UserDefaults.standard.set(date, forKey: "RateDate")
        }
    }
    
    func getRateDate() -> String? {
        UserDefaults.standard.string(forKey: "RateDate")
    }
}

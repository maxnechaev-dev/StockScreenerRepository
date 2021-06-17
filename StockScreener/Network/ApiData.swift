//
//  ApiData.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.06.2021.
//

import Foundation

struct ApiData {
    
    static let tokenForIExapis = "sk_72487b2d2a744574a47183726ead7ba5"
        
    static let trendUrl = "https://cloud.iexapis.com/stable/stock/market/list/mostactive?token=\(tokenForIExapis)"
        
}



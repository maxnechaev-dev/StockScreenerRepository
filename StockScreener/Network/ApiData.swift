//
//  ApiData.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.06.2021.
//

import Foundation

struct ApiData {
    
    static let tokenForIExapis = "sk_df786d56dc4f49608540541174f42d4a"
        
    static let trendUrl = "https://cloud.iexapis.com/stable/stock/market/list/mostactive?token=\(tokenForIExapis)"
        
}



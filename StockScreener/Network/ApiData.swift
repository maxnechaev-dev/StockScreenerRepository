//
//  ApiData.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.06.2021.
//

import Foundation

struct ApiData {
    
    static let tokenForIExapis = "pk_f264faaab1d94c1fbd943a8c66219a0e"
        
    static let trendUrl = "https://cloud.iexapis.com/stable/stock/market/list/mostactive?token=\(tokenForIExapis)"
        
}



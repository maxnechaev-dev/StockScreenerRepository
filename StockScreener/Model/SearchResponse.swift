//
//  SearchResponse.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.06.2021.
//

import Foundation

// MARK: - MostActiveElement
struct MostActiveElement: Codable {
    let symbol, companyName, primaryExchange: String
    let calculationPrice: CalculationPrice
    let mostActiveOpen, openTime: JSONNull?
    let openSource: Source
    let close, closeTime: JSONNull?
    let closeSource: Source
    let high: JSONNull?
    let highTime: Int?
    let highSource: String?
    let low: JSONNull?
    let lowTime: Int?
    let lowSource: String?
    let latestPrice: Double
    let latestSource: LatestSource
    let latestTime: String
    let latestUpdate: Int
    let latestVolume: JSONNull?
    let iexRealtimePrice: Double
    let iexRealtimeSize, iexLastUpdated: Int
    let delayedPrice, delayedPriceTime, oddLotDelayedPrice, oddLotDelayedPriceTime: JSONNull?
    let extendedPrice, extendedChange, extendedChangePercent, extendedPriceTime: JSONNull?
    let previousClose: Double
    let previousVolume: Int
    let change, changePercent: Double
    let volume: JSONNull?
    let iexMarketPercent: Double
    let iexVolume, avgTotalVolume: Int
    let iexBidPrice: Double
    let iexBidSize: Int
    let iexAskPrice: Double
    let iexAskSize: Int
    let iexOpen: Double
    let iexOpenTime: Int
    let iexClose: Double
    let iexCloseTime, marketCap: Int
    let peRatio: Double?
    let week52High, week52Low, ytdChange: Double
    let lastTradeTime: Int
    let isUSMarketOpen: Bool

    enum CodingKeys: String, CodingKey {
        case symbol, companyName, primaryExchange, calculationPrice
        case mostActiveOpen = "open"
        case openTime, openSource, close, closeTime, closeSource, high, highTime, highSource, low, lowTime, lowSource, latestPrice, latestSource, latestTime, latestUpdate, latestVolume, iexRealtimePrice, iexRealtimeSize, iexLastUpdated, delayedPrice, delayedPriceTime, oddLotDelayedPrice, oddLotDelayedPriceTime, extendedPrice, extendedChange, extendedChangePercent, extendedPriceTime, previousClose, previousVolume, change, changePercent, volume, iexMarketPercent, iexVolume, avgTotalVolume, iexBidPrice, iexBidSize, iexAskPrice, iexAskSize, iexOpen, iexOpenTime, iexClose, iexCloseTime, marketCap, peRatio, week52High, week52Low, ytdChange, lastTradeTime, isUSMarketOpen
    }
}

enum CalculationPrice: String, Codable {
    case tops = "tops"
}

enum Source: String, Codable {
    case official = "official"
}

enum LatestSource: String, Codable {
    case iexRealTimePrice = "IEX real time price"
}

typealias MostActive = [MostActiveElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

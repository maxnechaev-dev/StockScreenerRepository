
import Foundation

//Модель запроса данных для основного окна приложения. Самые активные компании.
struct MostActiveElement: Codable {
    let symbol: String
    let companyName: String
    let change: Double
    let changePercent: Double
    let iexRealtimePrice: Double?
    let close: Double?
    let latestPrice: Double?
}

typealias MostActive = [MostActiveElement]


//Модель запроса данных для логотипов компаний

struct CompanyLogo: Codable {
    var url: String
}

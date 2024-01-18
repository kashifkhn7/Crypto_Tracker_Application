//
//  MarketDataModel.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 08/08/2023.
//

import Foundation

//API and JSON Data
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON response:
 {
   "data": {
     "active_cryptocurrencies": 10023,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 798,
     "total_market_cap": {
       "btc": 41394881.21229697,
       "eth": 661010970.7105083,
       "ltc": 14666225689.353962,
       "bch": 5083786142.332672,
       "bnb": 4996361992.735915,
       "eos": 1678167195354.945,
       "xrp": 1943516172206.7,
       "xlm": 8451981740720.161,
       "link": 165582729375.90158,
       "dot": 243540179651.34183,
       "yfi": 188995320.99297976,
       "usd": 1207915865206.0317,
       "aed": 4436705170798.381,
       "ars": 342051575129718.25,
       "aud": 1837421218358.1543,
       "bdt": 132040654518851.3,
       "bhd": 455436221564.878,
       "bmd": 1207915865206.0317,
       "brl": 5919391697442.146,
       "cad": 1615406282333.2854,
       "chf": 1053956116942.737,
       "clp": 1041306780933160.4,
       "cny": 8689021984773.079,
       "czk": 26605917221787.62,
       "dkk": 8179764656002.193,
       "eur": 1097753938299.2432,
       "gbp": 944932046780.9713,
       "hkd": 9430670246850.93,
       "huf": 425985041611774.1,
       "idr": 18390723266473444,
       "ils": 4452094018921.114,
       "inr": 99962116232769.44,
       "jpy": 172104758411454.53,
       "krw": 1580074743276012,
       "kwd": 371422049392.20264,
       "lkr": 391149249344317.4,
       "mmk": 2535105993418591,
       "mxn": 20624680232046.914,
       "myr": 5506888429474.322,
       "ngn": 927957205127231,
       "nok": 12256890184550.857,
       "nzd": 1978028664647.4663,
       "php": 67901781238776.07,
       "pkr": 342546293983135.4,
       "pln": 4856484923938.239,
       "rub": 115657947717225.23,
       "sar": 4531455299181.007,
       "sek": 12792047645303.488,
       "sgd": 1619694383654.7693,
       "thb": 42075830994057.984,
       "try": 32626291893476.867,
       "twd": 38274019689086.59,
       "uah": 44587183503174.93,
       "vef": 120948615583.07996,
       "vnd": 28664360163726748,
       "zar": 22610010748099.57,
       "xdr": 903007702931.4011,
       "xag": 52237022182.03679,
       "xau": 623574486.253961,
       "bits": 41394881212296.97,
       "sats": 4139488121229697
     },
     "total_volume": {
       "btc": 1374475.7706628207,
       "eth": 21948210.42544769,
       "ltc": 486977405.5807968,
       "bch": 168802051.63608283,
       "bnb": 165899219.887991,
       "eos": 55721869023.0555,
       "xrp": 64532517315.109604,
       "xlm": 280639629260.57184,
       "link": 5498009485.7667265,
       "dot": 8086508918.745255,
       "yfi": 6275401.254112661,
       "usd": 40107642324.425995,
       "aed": 147316372948.67465,
       "ars": 11357481615219.338,
       "aud": 61009740121.80057,
       "bdt": 4384278322912.739,
       "bhd": 15122305784.928556,
       "bmd": 40107642324.425995,
       "brl": 196547501210.84915,
       "cad": 53637955462.57107,
       "chf": 34995562341.39701,
       "clp": 34575553747315.793,
       "cny": 288510314296.52625,
       "czk": 883422962130.5044,
       "dkk": 271600932292.54752,
       "eur": 36449825344.43839,
       "gbp": 31375526760.47898,
       "hkd": 313136005607.30054,
       "huf": 14144408709795.828,
       "idr": 610645635268151.5,
       "ils": 147827344311.88812,
       "inr": 3319142433130.279,
       "jpy": 5714566959115.966,
       "krw": 52464806924581.7,
       "kwd": 12332698938.337748,
       "lkr": 12987720949830.984,
       "mmk": 84175667666388.84,
       "mxn": 684821949632.6442,
       "myr": 182850741357.05887,
       "ngn": 30811894062893.82,
       "nok": 406977821628.23334,
       "nzd": 65678470226.5755,
       "php": 2254610965517.6426,
       "pkr": 11373908261640.295,
       "pln": 161254741239.8284,
       "rub": 3840306872886.7188,
       "sar": 150462456520.24493,
       "sek": 424747191698.9323,
       "sgd": 53780337592.82286,
       "thb": 1397086029435.3623,
       "try": 1083323502347.3182,
       "twd": 1270850674476.4775,
       "uah": 1480472986331.596,
       "vef": 4015978225.944774,
       "vnd": 951771508282310.9,
       "zar": 750742870557.0714,
       "xdr": 29983470710.682827,
       "xag": 1734478254.7523544,
       "xau": 20705169.273561645,
       "bits": 1374475770662.8206,
       "sats": 137447577066282.06
     },
     "market_cap_percentage": {
       "btc": 46.9888412053754,
       "eth": 18.17756558717377,
       "usdt": 6.911759780660655,
       "bnb": 3.078646039693606,
       "xrp": 2.7098151669636525,
       "usdc": 2.1651020895433954,
       "steth": 1.2061707363516778,
       "doge": 0.8536703009849033,
       "ada": 0.841804834150401,
       "sol": 0.774133869141624
     },
     "market_cap_change_percentage_24h_usd": 0.08789354530189583,
     "updated_at": 1691452732
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String , CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String{
        if let item = totalMarketCap.first(where: { $0.key == "usd"}){
            return "$" + item.value.formattedwithAbbreviations()
        }
        return ""
    }
    
    var volumn: String{
        if let item = totalVolume.first(where: { $0.key == "usd"}){
            return "$" + item.value.formattedwithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String{
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}){
            return item.value.asPercentString()
        }
        return ""
    }
    
}

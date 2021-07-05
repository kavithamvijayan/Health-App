//
//  NewslistModel.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import Foundation

struct NewslistModel: Codable {
    private var global: Global?
    private var countries: [Countries]?
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
    
    var getGlobal: Global? {
        return global
    }
    
    var getCountries: [Countries]? {
        return countries
    }
}

struct Global: Codable {
    private var totalConfirmed: Int?
    private var totalDeaths: Int?
    private var totalRecovered: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
        case totalRecovered = "TotalRecovered"
    }
    
    var getConfirmed: Int? {
        return totalConfirmed
    }
    
    var getDeaths: Int? {
        return totalDeaths
    }
    
    var getRecovered: Int? {
        return totalRecovered
    }
}

struct Countries: Codable {
    private var country: String?
    private var totalConfirmed: Int?
    private var totalDeaths: Int?
    private var totalRecovered: Int?
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
        case totalRecovered = "TotalRecovered"
    }
    
    var getCountry: String? {
        return country
    }
    
    var getConfirmed: Int? {
        return totalConfirmed
    }
    
    var getDeaths: Int? {
        return totalDeaths
    }
    
    var getRecovered: Int? {
        return totalRecovered
    }
}

/*
 {
 "Global": {
     "NewConfirmed": 227941,
     "TotalConfirmed": 20088890,
     "NewDeaths": 4913,
     "TotalDeaths": 736223,
     "NewRecovered": 164695,
     "TotalRecovered": 12279869
 },
 "Countries": [
     {
         "Country": "Afghanistan",
         "CountryCode": "AF",
         "Slug": "afghanistan",
         "NewConfirmed": 108,
         "TotalConfirmed": 37162,
         "NewDeaths": 16,
         "TotalDeaths": 1328,
         "NewRecovered": 268,
         "TotalRecovered": 26228,
         "Date": "2020-08-11T18:11:57Z",
         "Premium": {}
     },
 */

//
//  AppConfigurations.swift
//  Formula
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation

class AppConfigurations {
    lazy var googleApiKey = Bundle.main.object(forInfoDictionaryKey: "GoogleApiKey") as! String
    lazy var googleApiBaseURL = Bundle.main.object(forInfoDictionaryKey: "GoogleApiBaseURL") as! String
    
    lazy var formulaApiBaseURL = Bundle.main.object(forInfoDictionaryKey: "FormulaApiBaseURL") as! String
    
    lazy var newsApiKey = Bundle.main.object(forInfoDictionaryKey: "NewsApiKey") as! String
    lazy var newsApiBaseURL = Bundle.main.object(forInfoDictionaryKey: "NewsApiBaseURL") as! String
    
    lazy var formulaSportsApiKey = Bundle.main.object(forInfoDictionaryKey: "FormulaSportsApiKey") as! String
    lazy var formulaSportsApiBaseURL = Bundle.main.object(forInfoDictionaryKey: "FormulaSportsApiBaseURL") as! String
}

//
//  MastercardAPI.swift
//  Travel KZH
//
//  Created by Julien Widmer on 2022-07-06.
//
// Mastercard API - Enhanced Currency Conversion Calculator
// https://developer.mastercard.com/enhanced-currency-conversion-calculator/documentation/api-reference/
// Conversion-rate-summary

import Foundation

// MARK: - Only properties needed to be returned by the API for the app
struct CustomMastercardProperties: Decodable {
    // Properties
    let requestDate: String
    let data: CustomMastercardData
}

struct CustomMastercardData: Decodable {
    // Properties
    let effectiveConversionRate: Double
}


// MARK: - All expected properties to be returned by the API
struct ConversionRateSummary: Decodable {
    // Properties
    let name: String
    let description: String
    let requestDate: String
    let data: ConversionRateSummaryData
}

struct ConversionRateSummaryData: Decodable {
    // Properties
    let transCurr: String
    let crdhldBillCurr: String
    let rateDate: String
    let transAmt: Double
    let bankFeePct: Double
    let bankFeeFixed: Double
    
    let mastercard: ConversionRateSummaryMastercard
    let ecb: ConversionRateSummaryECB
    
    let effectiveConversionRate: Double
    let pctDifferenceMastercardExclAllFeesAndEcb: Double
    let pctDifferenceMastercardInclAllFeesAndEcb: Double
}

struct ConversionRateSummaryMastercard: Decodable {
    // Properties
    let mastercardFxRateDate: String
    let mastercardConvRateInclPctFee: Double
    let mastercardConvRateExclAllFees: Double
    let crdhldBillAmtInclAllFees: Double
    let crdhldBillAmtExclAllFees: Double
}

struct ConversionRateSummaryECB: Decodable {
    // Properties
    let ecbReferenceRateDate: String
    let ecbReferenceRate: Double
}

//
//  ApiService.swift
//  Travel KZH
//
//  Created by Joe Pham on 2022-08-29.
//

import Foundation
import MastercardOAuth1Signer

protocol ApiService {
	func getUrl() -> URL
}

/// Implementation class of `ApiService`
/// tailored to working with MasterCard Api
final class ApiServiceImpl: ApiService {
	
	// TODO: Refactor method to get currency rate here
	
	/// Get and create Mastercard API URL
	func getUrl() -> URL {
		let cardCurrency = "CHF"
		let transactionCurrency = "KZT"
		let date = Date.now.getFormattedDate()
		
		var urlString = "https://sandbox.api.mastercard.com/enhanced/settlement/currencyrate/subscribed/summary-rates"
		urlString += "?rate_date=\(date)"
		urlString += "&trans_curr=\(transactionCurrency)"
		urlString += "&trans_amt=1"
		urlString += "&crdhld_bill_curr=\(cardCurrency)"
		
		return URL(string: urlString)!
	}
}

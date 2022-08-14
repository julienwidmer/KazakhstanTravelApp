//
//  ContentView.swift
//  Travel KZH
//
//  Created by Julien Widmer on 2022-07-05.
//

import SwiftUI
import MastercardOAuth1Signer

struct ContentView: View {
    // MARK: Properties
    @State private var rateInfo: CustomMastercardProperties?
    @State private var rate = UserDefaults().getRate() ?? 0.0
    @State private var rateDate = UserDefaults().getRateDate()
    
    @FocusState private var customKZTAmountIsFocused: Bool
    @State private var customKZTAmount: Double?
    var convertedCHFAmount: Double { (customKZTAmount ?? 0) * rate }
    
    @State private var displayAlert = false
    @State private var errorMessage: String?
    
    var body: some View {
        TabView {
            // MARK: - NavigationView - Currency
            NavigationView {
                List {
                    Section {
                        // MARK: Custom KZT amount
                        HStack {
                            // KZT TextField to convert in CHF
                            HStack {
                                Text("₸")
                                
                                TextField("0.00",
                                          value: $customKZTAmount,
                                          format: .number) //format: .currency(code: "KZT"))
                                .keyboardType(.decimalPad)
                                .focused($customKZTAmountIsFocused)
                                
                                Image(systemName: "keyboard")
                                    .font(.system(size: 15))
                            }
                            .frame(width: nil, height: 45, alignment: .leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 12)
                            .background(Color(#colorLiteral(red: 0.6705882549,
                                                            green: 0.6705882549,
                                                            blue: 0.6705882549,
                                                            alpha: 0.2)))
                            .cornerRadius(7)
                            
                            // KZT amount converted in CHF
                            Text(convertedCHFAmount, format: .currency(code: "CHF"))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.vertical, 4)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                    } header: {
                        if let info = getHeaderString() {
                            Text(info)
                        }
                    }
                    
                    Section {
                        let amountsToConvert = [200, 500, 1_000, 2_000, 5_000, 10_000, 20_000]
                        
                        ForEach(amountsToConvert, id: \.self) { amount in
                            HStack {
                                Text("₸ \(amount)")
                                
                                Spacer()
                                
                                if rate != 0 {
                                    Text(String(format: "CHF %.2f", (Double(amount) * rate)))
                                } else {
                                    Text("CHF n/a")
                                }
                            }
                            .font(.system(size: 17, weight: .regular, design: .rounded))
                        }
                    } footer: {
                        Text(getFooterString())
                    }
                }
                .alert("API Error", isPresented: $displayAlert) {
                    Button("Continue") {}
                } message: {
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                    }
                }
                .onTapGesture() {
                    customKZTAmountIsFocused.toggle()
                }
                .refreshable {
                    getCurrentRate()
                }
                .navigationTitle("Kazakhstan 🇰🇿")
                //            .navigationBarTitle("Kazakhstan 🇰🇿", displayMode: .inline)
                .toolbar {
                    Button {
                        getCurrentRate()
                    } label: {
                        Label("Refresh Rate", systemImage: "arrow.clockwise")
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Clear") {
                            // TODO: Remove focus works but not practical
                            customKZTAmountIsFocused.toggle()
                            customKZTAmount = nil
                        }
                        
                        Spacer()
                        
                        Button("Done") {
                            customKZTAmountIsFocused.toggle()
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "tengesign.square")
                Text("Currency")
            }
            // MARK: - NavigationView - Vocabulary
            NavigationView {
                Form {
                    Section {
                        let glossary: [Glossary] = [.greetings, .conversations, .dining, .food, .weather]
                        
                        List(glossary, children: \.terms) { term in
                            
                            if let englishTranslation = term.englishTranslation {
                                HStack {
                                    Text(englishTranslation)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .font(Font.system(size: 16, design: .default))
                                    
                                    Spacer()
                                    Text(term.russianTranslation!)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .font(Font.system(size: 16, design: .monospaced))
                                }
                            } else {
                                Image(systemName: term.icon)
                                Text(term.categoryName)
                            }
                            
                        }
                    } header: {
                        Text("Basic words and sentences")
                    }
                }
                .navigationTitle("Kazakhstan 🇰🇿")
            }
            .tabItem {
                Image(systemName: "person.2.wave.2.fill")
                Text("Vocabulary")
            }
        }
    }
    
    // MARK - Update rate provided by Mastercard API
    func getCurrentRate() {
        // TODO: - Import your certificate in this Xcode project
        // TODO: - Change the name with the one from your certificate
        let certificateName = "YOUR_CERTIFICATE_NAME_HERE"
        let certificateExtension = "p12"
        
        if let certificatePath = Bundle.main.path(forResource: certificateName, ofType: certificateExtension) {
            // Certificate path retrieved ✅
            // TODO: - Change the password with the one from your certificate readme.txt
            let keystorePassword = "YOUR_KEYSTORE_PASSWORD" // from certificate readme.txt
            
            if let signingKey = KeyProvider.loadPrivateKey(fromPath: certificatePath, keyPassword: keystorePassword) {
                // Private Key loaded ✅
                // TODO: - Edit the Consumer Key with the one from the Mastercard Developer Portal
                let consumerKey = "YOUR_CONSUMER_KEY_HERE" // from developer portal
                let url = getURL()
                
                do {
                    let header = try OAuth.authorizationHeader(forUri: url, method: "GET", payload: nil, consumerKey: consumerKey, signingPrivateKey: signingKey)
                    // OAuth Authorization Header created ✅
                    var urlRequest = URLRequest(url: url)
                    urlRequest.httpMethod = "GET"
                    urlRequest.allHTTPHeaderFields = [
                        "Authorization": header, // Add token in request header
                        "Accept": "application/json",
                        "Referer": "api.mastercard.com"
                    ]
                    
                    
                    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                        if let data = data {
                            if let response = try? JSONDecoder().decode(CustomMastercardProperties.self, from: data) {
                                DispatchQueue.main.async {
                                    // Save locally/Update local rate
                                    updateLocalData(rate: response.data.effectiveConversionRate, rateDate: response.requestDate)
                                }
                                
                                return
                            } else {
                                errorMessage = "Failed to decode JSON object."
                                displayAlert.toggle()
                            }
                        } else if let error = error {
                            errorMessage = "HTTP request failed: \(error)."
                            displayAlert.toggle()
                        }
                    }
                    
                    task.resume()
                } catch {
                    errorMessage = "Failed to create the OAuth Authorization Header."
                    displayAlert.toggle()
                }
            } else {
                errorMessage = "Failed to load the Private Key."
                displayAlert.toggle()
            }
        } else {
            errorMessage = "Failed to locate the project's certificate."
            displayAlert.toggle()
        }
    }
    
    // MARK - Get and create Mastercard API URL
    func getURL() -> URL {
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
    
    // MARK - Get Footer Date
    func getFooterString() -> String {
        if let date = UserDefaults().getRateDate()?.toDate() {//rateDate?.toDate() {
            let formattedDate = date.getReadableDate()
            return "Last updated: \(formattedDate)"
        }
        
        return "Pull to refresh the exchange rate."
    }
    
    // MARK - Get Header Date
    func getHeaderString() -> String? {
        return rate != 0 ? "Exchange rate \(rate)" : nil
    }
    
    func updateLocalData(rate: Double, rateDate: String) {
        UserDefaults().saveRate(rate)
        UserDefaults().saveRateDate(rateDate)
        self.rate = rate
        self.rateDate = rateDate
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

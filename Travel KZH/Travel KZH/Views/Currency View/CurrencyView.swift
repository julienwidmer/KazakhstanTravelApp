//
//  CurrencyView.swift
//  Travel KZH
//
//  Created by Joe Pham on 2022-08-29.
//

import SwiftUI

struct CurrencyView: View {
	// MARK: Properties
	@StateObject
	private var viewModel: CurrencyView.ViewModel
	
	init(viewModel: CurrencyView.ViewModel = .init()) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	@FocusState private var customKZTAmountIsFocused: Bool
	
    var body: some View {
		List {
			Section {
				// MARK: Custom KZT amount
				HStack {
					// KZT TextField to convert in CHF
					HStack {
						Text("₸")
						
						TextField(
							"0.00",
							value: $viewModel.customKZTAmount,
							format: .number
						) //format: .currency(code: "KZT"))
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
					Text(
						viewModel.convertedCHFAmount,
						format: .currency(code: "CHF")
					)
					.frame(
						minWidth: 0,
						maxWidth: .infinity,
						alignment: .trailing
					)
				}
				.padding(.vertical, 4)
				.font(.system(size: 17, weight: .regular, design: .rounded))
			} header: {
				if let info = viewModel.getHeaderString() {
					Text(info)
				}
			}
			
			Section {
				let amountsToConvert = [200, 500, 1_000, 2_000, 5_000, 10_000, 20_000]
				
				ForEach(amountsToConvert, id: \.self) { amount in
					HStack {
						Text("₸ \(amount)")
						
						Spacer()
						
						if viewModel.rate != 0 {
							Text(String(format: "CHF %.2f", (Double(amount) * viewModel.rate)))
						} else {
							Text("CHF n/a")
						}
					}
					.font(.system(size: 17, weight: .regular, design: .rounded))
				}
			} footer: {
				Text(viewModel.getFooterString())
			}
		}
		.alert("API Error", isPresented: $viewModel.displayAlert) {
			Button("Continue") {}
		} message: {
			if let errorMessage = viewModel.errorMessage {
				Text(errorMessage)
			}
		}
		.onTapGesture() {
			customKZTAmountIsFocused.toggle()
		}
		.refreshable {
			viewModel.getCurrentRate()
		}
		.navigationTitle("Kazakhstan 🇰🇿")
		//            .navigationBarTitle("Kazakhstan 🇰🇿", displayMode: .inline)
		.toolbar {
			Button {
				viewModel.getCurrentRate()
			} label: {
				Label("Refresh Rate", systemImage: "arrow.clockwise")
			}
		}
		.toolbar {
			ToolbarItemGroup(placement: .keyboard) {
				Button("Clear") {
					// TODO: Remove focus works but not practical
					customKZTAmountIsFocused.toggle()
					viewModel.customKZTAmount = nil
				}
				
				Spacer()
				
				Button("Done") {
					customKZTAmountIsFocused.toggle()
				}
			}
		}
    }
}

private extension CurrencyView {
	
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}

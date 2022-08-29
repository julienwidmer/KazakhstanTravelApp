//
//  VocabularyView.swift
//  Travel KZH
//
//  Created by Joe Pham on 2022-08-29.
//

import SwiftUI

struct VocabularyView: View {
    var body: some View {
		Form {
			Section {
				let glossary: [Glossary] = [.greetings, .conversations, .dining, .food, .weather]
				
				List(glossary, children: \.terms) { term in
					
					if let englishTranslation = term.englishTranslation {
						HStack {
							Text(englishTranslation)
								.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
								.font(.system(.callout, design: .default))
							
							Spacer()
							Text(term.russianTranslation!)
								.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
								.font(.system(.callout, design: .monospaced))
						}
					} else {
						Symbols.forGlossaryTerm(term)
						Text(term.categoryName)
					}
					
				}
			} header: {
				Text("Basic words and sentences")
			}
		}
		.navigationTitle("Kazakhstan 🇰🇿")
    }
}

struct VocabularyView_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyView()
    }
}

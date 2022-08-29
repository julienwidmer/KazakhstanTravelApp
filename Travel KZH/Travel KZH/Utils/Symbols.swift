//
//  Symbols.swift
//  Travel KZH
//
//  Created by Joe Pham on 2022-08-29.
//

import SwiftUI

enum Symbols {
	static let keyboard: Image = .init(systemName: "keyboard")
	static let tengesignSquared: Image = .init(systemName: "tengesign.square")
	static let twoPersonsWithWaveFilled: Image = .init(systemName: "person.2.wave.2.fill")
	
	static func forGlossaryTerm(_ term: Glossary) -> Image {
		Image(systemName: term.icon)
	}
}

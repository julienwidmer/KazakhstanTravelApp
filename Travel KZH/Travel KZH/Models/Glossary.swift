//
//  Glossary.swift
//  Travel KZH
//
//  Created by Julien Widmer on 2022-07-08.
//

import Foundation

// A glossary of English words and sentences translated to Russian
struct Glossary: Identifiable {
    // MARK: Properties
    let id = UUID()
    let categoryName: String
    let englishTranslation: String?
    let russianTranslation: String?
    let icon: String
    var terms: [Glossary]?
    
    // MARK: Groups
    static let greetings = Glossary(
        categoryName: "Greetings",
        englishTranslation: nil,
        russianTranslation: nil,
        icon: "person",
        terms: [
            Glossary(categoryName: "",
                        englishTranslation: "Good morning",
                         russianTranslation: "Доброе утро",
                         icon: ""),
            Glossary(categoryName: "",
                         englishTranslation: "Good evening",
                         russianTranslation: "Добрый вечер",
                         icon: "")
    ])
    
    static let conversations = Glossary(
        categoryName: "Conversations",
        englishTranslation: nil,
        russianTranslation: nil,
        icon: "person.2", terms: [
            Glossary(categoryName: "",
                         englishTranslation: "I speak very little Russian",
                         russianTranslation: "Я немного говорю по-русский",
                         icon: ""),
            Glossary(categoryName: "",
                         englishTranslation: "Nice to meet you!",
                         russianTranslation: "Рад познакомится!",
                         icon: ""),
            Glossary(categoryName: "",
                         englishTranslation: "What are we doing today?",
                         russianTranslation: "Что мы делаем сегодня?",
                         icon: ""),
            Glossary(categoryName: "",
                         englishTranslation: "How was your day?",
                         russianTranslation: "Как прошел день?",
                         icon: ""),
            Glossary(categoryName: "",
                         englishTranslation: "How was your morning?",
                         russianTranslation: "Как прошло утро?",
                         icon: ""),
            Glossary(categoryName: "",
                         englishTranslation: "How was your evening?",
                         russianTranslation: "Как прошел вечер?",
                         icon: ""),
            Glossary(categoryName: "",
                         englishTranslation: "I don't understand",
                         russianTranslation: "Я не понимаю",
                         icon: "")
    ])
    
    static let dining = Glossary(
        categoryName: "Dining",
        englishTranslation: nil,
        russianTranslation: nil,
        icon: "takeoutbag.and.cup.and.straw",
        terms: [
            Glossary(categoryName: "",
                     englishTranslation: "Thank you for the breakfast",
                     russianTranslation: "Спасибо за завтрак",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "Thank you for the lunch",
                     russianTranslation: "Спасибо за обед",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "Thank you for the diner",
                     russianTranslation: "Спасибо за ужин",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "It is delicious",
                     russianTranslation: "Это вкусно",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "It smells good",
                     russianTranslation: "Пахнет вкусно",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "Can I please get some water?",
                     russianTranslation: "Можно пожалуйста воды?",
                     icon: "")
    ])
    
    static let food = Glossary(
        categoryName: "Food",
        englishTranslation: nil,
        russianTranslation: nil,
        icon: "cup.and.saucer", terms: [
            Glossary(categoryName: "",
                     englishTranslation: "Chicken",
                     russianTranslation: "Курица",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "Beef",
                     russianTranslation: "Говядина",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation:
                        "Lamb",
                     russianTranslation: "Ягненок",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "Water",
                     russianTranslation: "вода",
                     icon: "")
    ])
    
    static let weather = Glossary(
        categoryName: "Weather",
        englishTranslation: nil,
        russianTranslation: nil,
        icon: "cloud.sun.rain",
        terms: [
            Glossary(categoryName: "",
                     englishTranslation: "It was raining",
                     russianTranslation: "Был дождь",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "It was cold",
                     russianTranslation: "Было холодно",
                     icon: ""),
            Glossary(categoryName: "",
                     englishTranslation: "It was hot",
                     russianTranslation: "Было жарко",
                     icon: "")
    ])
}

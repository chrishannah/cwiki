//
//  main.swift
//  Command Wiki
//
//  Created by Christopher Hannah on 22/03/2017.
//  Copyright © 2017 Christopher Hannah. All rights reserved.
//

import Foundation

let wiki = Wiki()

if CommandLine.arguments.count == 2 {
    let query = CommandLine.arguments[1]
    let results = wiki.searchWikipedia(query)
    for result in results {
        print("📘 " + result.title)
        print("📖 " + result.text)
        print("🌍 " + result.url)
        print("")
    }
} else {
    print("Use the command with the one argument wrapped in quotation marks for the search query.")
}


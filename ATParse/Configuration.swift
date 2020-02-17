//
//  Configuration.swift
//  ATParse
//
//  Created by Nicolas Landa on 25/1/18.
//  Copyright © 2018 Nicolas Landa. All rights reserved.
//

import os
import Parse

@available(iOS 10.0, *)
private let customLog = OSLog(subsystem: "com.aratech.ATParse", category: "ParseClientConfiguration")

public extension ParseClientConfiguration {
	
	struct PlistConfiguration: Codable {
		public let applicationId: String
		public let clientKey: String
		public let server: String
	}
	
	static func readFrom(url: URL) -> ParseClientConfiguration? {
		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			let configuration = try decoder.decode(PlistConfiguration.self, from: data)
			
			return ParseClientConfiguration { (parseConfiguration) -> Void in
				parseConfiguration.applicationId = configuration.applicationId
				parseConfiguration.clientKey = configuration.clientKey
				parseConfiguration.server = configuration.server
			}
			
		} catch let error {
			if #available(iOS 10.0, *) {
				os_log("%@", log: customLog, type: .error, error.localizedDescription)
			} else {
				NSLog(error.localizedDescription)
			}
			
			return nil
		}
	}
	
	static func readFrom(string: String) -> ParseClientConfiguration? {
		
		let fileURL = URL(fileURLWithPath: string)
		
		guard (try? fileURL.checkResourceIsReachable()) != nil else { return nil }
		
		return self.readFrom(url: fileURL)
	}
}

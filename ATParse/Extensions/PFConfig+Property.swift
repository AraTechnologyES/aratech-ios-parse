//
//  PFConfig+Property.swift
//  ATParse
//
//  Created by Nicolás Landa on 20/7/18.
//  Copyright © 2018 AraTech. All rights reserved.
//

import Parse

public extension PFConfig {
	
	public subscript<T>(key: PFConfigKey<T>) -> T? {
		return (self.object(forKey: key.rawValue) as? T) ?? key.defaultValue
	}
}

/**

Claves para acceder a los parámetros de PFConfig, añade las tuyas.

```
extension PFConfigKeys {
public static let defaultUrl = PFConfigKey<String>(forKey: "defaultUrl")
}
```

*/
open class PFConfigKeys { fileprivate init() {} }

/// Clave para obtener un parámetro de un PFConfig.
open class PFConfigKey<ValueType>: PFConfigKeys, RawRepresentable {
	
	public let rawValue: String
	internal let defaultValue: ValueType?
	
	// MARK: - Init
	
	public required init(rawValue: String) {
		self.rawValue = rawValue
		self.defaultValue = nil
	}
	
	convenience public init(forKey key: String, defaultValue: ValueType) {
		self.init(rawValue: key)
	}
	
	convenience public init(forKey key: String) {
		self.init(rawValue: key)
	}
}

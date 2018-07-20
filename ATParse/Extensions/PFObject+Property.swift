//
//  PFObject+Property.swift
//  ATParse
//
//  Created by Nicolas Landa on 4/1/17.
//  Copyright © 2018 AraTech. All rights reserved.
//

import Parse

public extension PFObject {
	
	/// Compara dos objectos ATParse
	///
	/// - Parameters:
	///   - lhs:
	///   - rhs:
	/// - Returns: Devuelve `true` si los `objectId` de ambos objetos coinciden
	public static func == (lhs: PFObject, rhs: PFObject) -> Bool {
		return lhs.objectId == rhs.objectId
	}
	
	/// Recupera una propiedad de tipo `T` del PFObject
	///
	/// - Parameter key: La clave del valor a recuperar
	/// - Returns: El valor de la propiedad recuperada
	public func property<T>(forKey key: String) -> T? {
		let value = self.object(forKey: key) as? T
		return value
	}
	
	/// Establece una propiedad de tipo `T` del PFObject
	///
	/// - Parameter key: La clave del valor a establecer
	/// - Returns: El valor de la propiedad establecida
	public func setProperty<T>(_ property: T, forKey key: String) {
		self.setObject(property, forKey: key)
	}
}

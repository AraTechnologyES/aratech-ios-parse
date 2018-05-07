//
//  API.swift
//  ATParse
//
//  Created by Nicolas Landa on 21/12/16.
//  Copyright © 2016 Nicolas Landa. All rights reserved.
//

import Foundation
import Parse

open class ATParse {
	
	/// Instancia por defecto.
	public static let `default`: ATParse = ATParse()
	
    /// Realiza el login en el servidor Parse
    ///
    /// - Parameters:
    ///   - type: Tipo de login
    ///   - queue: Cola en la que ejecutar el bloque de terminación, principal por defecto
    ///   - completion: Bloque de terminación, nulo por defecto
    public func login(_ type: LoginType, queue: DispatchQueue = .main, completion: UserLogResult? = nil) {
        
        let loginOperation = LoginOperation(type, completionQueue: queue)
        loginOperation.completion = completion
        
        let queue = OperationQueues.parse
        
        queue.addOperation(loginOperation)
    }
	
    /// Recupera del servidor Parse los objetos del tipo *T* especificado. El tipo T debe implementar el protocolo PFSubclassing.
    ///
    /// - Parameters:
    ///   - query: Consulta para la petición
    ///   - includedKeys: Claves a incluir en la búsqueda para obtener los objetos relacionados, ninguna por defecto
    ///   - async: Si la operación ha de realizarse de manera asíncrona, `true` por defecto
	///	  - pageSize: Número de elementos a recabar, `100` por defecto.
	///   - page: Página, si por ejemplo se desean los segundos 100 elementos, este parametro debería de valer 2 y pageSize `100`. Si se desean todos los objetos, pasar `0`.
	///   - orderBy: Ordenación de los resultados
    ///   - completionQueue: Cola en la que ejecutar el bloque de terminación, principal por defecto
    ///   - completion: Bloque de terminación, nulo por defecto
    /// - Returns: Operación de descarga
	@discardableResult
	public func fetchObjects<T>(withQuery query: PFQuery<T>,
								async: Bool = true,
								pageSize: Int = defaultPageSize,
								page: Int = 1,
								orderedBy orderBy: [OrderBy] = [],
								completionQueue: DispatchQueue = .main,
								completion: FetchPFObjectsResult<T>? = nil) -> ParseClassObjectsDownloadOperation<T> where T: PFSubclassing {
        
		let operation: ParseClassObjectsDownloadOperation<T> =
			ParseClassObjectsDownloadOperation<T>(query: query,
												  pageSize: pageSize,
												  page: page,
												  orderBy: orderBy,
												  completionQueue: completionQueue)
        
        operation.completion = completion
        
        let queue = OperationQueues.parse
        
        queue.addOperation(operation)
        
        if !async {
            queue.waitUntilAllOperationsAreFinished()
        }
        
        return operation
    }
}

//
//  RaaComponent.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//


public protocol RaaComponent: AnyObject {
	func hasChanged( _ entity: RaaEntityCollection.Entity )
}
public extension RaaComponent {
	func hasChanged( _ entity: RaaEntityCollection.Entity ) {}
}



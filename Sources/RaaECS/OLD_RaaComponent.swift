//
//  RaaComponent.swift
//
//
//  Created by the Dragon on 11.02.2022.
//


//import Foundation
//	//	//	//	//	//	//	//


//extension BaseRaaComponent: DBGInfo {
//}


open class BaseRaaComponent {
	public private(set) weak var entity:OLD_RaaEntity?
	//
	
	open func update( withDeltaTime deltaTime: Double ) {}
	open func onComponentListChanged() {}

	public init(forEntity:OLD_RaaEntity) {
		self.entity = forEntity
		//raaInitInfo()
	}
	deinit {
		//raaDEINITInfo()
	}
}


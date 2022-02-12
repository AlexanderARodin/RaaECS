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
	public private(set) weak var entity:RaaEntity?
	//
	
	open func update( withDeltaTime deltaTime: Double ) {}
	open func didAddToEntity() {}
	open func willRemoveFromEntity() {}

	public init(forEntity:RaaEntity) {
		self.entity = forEntity
		//raaInitInfo()
	}
	deinit {
		//raaDEINITInfo()
	}
}


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
	weak private(set) var entity:RaaEntity?
	//
	
	open func update( withDeltaTime deltaTime: Double ) {}//raaLog("FFFFFFFF")}
	
	init(forEntity:RaaEntity) {
		self.entity = forEntity
		//raaInitInfo()
	}
	deinit {
		//raaDEINITInfo()
	}
}


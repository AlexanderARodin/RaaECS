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



public class BaseRaaComponent {
	weak private(set) var entity:RaaEntity?
	//
	
	public func update( withDeltaTime deltaTime: Double ) {}//raaLog("FFFFFFFF")}
	
	init(forEntity:RaaEntity) {
		self.entity = forEntity
		//raaInitInfo()
	}
	deinit {
		//raaDEINITInfo()
	}
}


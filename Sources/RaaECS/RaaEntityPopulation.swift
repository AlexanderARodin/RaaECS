//
//  RaaEntityPopulation.swift
//
//
//  Created by the Dragon on 11.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//


//extension RaaEntityPopulation: DBGInfo {
//}


public class RaaEntityPopulation {
	public private(set) var entities:[RaaEntity] = []
	
	
	public init() {
		//raaInitInfo()
	}
	deinit {
		removeAllEntities()
		//raaDEINITInfo()
	}
	
	func removeAllEntities() {
		entities.removeAll() {entity in
			entity.removeAllComponents()
			return true
		}
	}
	func removeEmptyEntity() {
		entities.removeAll() {entity in
			entity.components.isEmpty
		}
	}
	func removeEntity(_ anEntity:RaaEntity) {
		entities.removeAll() {entity in
			if entity === anEntity {
				entity.removeAllComponents()
				return true
			}else{
				return false
			}
		}
	}
}


@resultBuilder
struct ComponentSequence {
	static func buildBlock(_ components: BaseRaaComponent...) -> [BaseRaaComponent] {
		return components
	}
	static func buildBlock() -> [BaseRaaComponent] {
		return []
	}
}

public extension RaaEntityPopulation {
	func createEntityFromComponents( @ComponentSequence _ call: (_ newEntity:RaaEntity)->[BaseRaaComponent] ) {
		let entity:RaaEntity = RaaEntity()
		let componentList = call(entity)
		for component in componentList {
			entity.addComponent(component)
		}
		if !entity.components.isEmpty {
			entities.append(entity)
		}
	}
	
	func sendUpdateWithDeltaTime<ComponentType>( seconds: Double, forType: ComponentType.Type ) {
		let listForUpdate: [(_ seconds:Double)->()] = getListForUpdating(forType: forType)
		sendForList( listForUpdate, withDeltaTime: seconds )
	}
	
	private func sendForList(_ listForUpdate:[(_ seconds:Double)->()], withDeltaTime: Double ) {
		for update in listForUpdate {
			update( withDeltaTime )
		}
	}
	private func getListForUpdating<ComponentType>(forType: ComponentType.Type) -> [(_ seconds:Double)->()] {
		var result:[(_ seconds:Double)->()] = []
		for entity in entities {
			for component in entity.components {
				if component is ComponentType {
					result.append(component.update(withDeltaTime:))
				}
			}
		}
		return result
	}
}

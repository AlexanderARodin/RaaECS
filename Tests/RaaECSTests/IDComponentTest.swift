//
//  IDComponentTest.swift
//  
//
//  Created by the Dragon on 13.02.2022.
//

import XCTest

@testable import RaaECS
//	//	//	//	//	//	//	/


class IDComponentTest: XCTestCase {
	//
	
	func testAddingAndSorting() throws {
		let world = IDComponentPopulation()
		XCTAssert(world.components.count == 0)
		world.addComponent( CompA(withID: 11) )
		XCTAssert(world.components.count == 1, String( world.components.count ) )
		world.addComponent( CompA(withID: 11) )
		XCTAssert(world.components.count == 1, String( world.components.count ) )
		world.addComponent( CompA(withID: 2) )
		XCTAssert(world.components.count == 2, String( world.components.count ) )
		world.addComponent( CompB(withID: 11) )
		XCTAssert(world.components.count == 3, String( world.components.count ) )
		world.addComponent( CompB(withID: 5) )
		XCTAssert(world.components.count == 4, String( world.components.count ) )
		for i in 0..<world.components.count {
			switch i {
			case 0:
				XCTAssert(world.components[i].id == 11)
			case 1:
				XCTAssert(world.components[i].id == 2)
			case 2:
				XCTAssert(world.components[i].id == 11)
			case 3:
				XCTAssert(world.components[i].id == 5)
			default:
				XCTAssert(false)
			}
		}
		world.sort()
		XCTAssert(world.components.count == 4, String( world.components.count ) )
		for i in 0..<world.components.count {
			switch i {
			case 0:
				XCTAssert(world.components[i].id == 2)
			case 1:
				XCTAssert(world.components[i].id == 5)
			case 2:
				XCTAssert(world.components[i].id == 11)
			case 3:
				XCTAssert(world.components[i].id == 11)
			default:
				XCTAssert(false)
			}
		}
		printWorld(world)
		world.createEntity() {newEntityID in
			CompA(withID: newEntityID )
		}
		printWorld(world)
	}
	func testCreatingAndDeletingEntity() throws {
		let world = IDComponentPopulation()
		XCTAssert(world.components.count == 0, String( world.components.count ) )
		weak var cmp:IDComponent?
		for i in 0..<6 {
			world.createEntity() {newEntityID in
				CompA(withID: newEntityID )
				if i == 3 {
					let ccc = getSecondComponent(newEntityID: newEntityID, cmp: &cmp)
					ccc
				}
			}
		}
		XCTAssertNotNil(cmp)
		XCTAssert(world.components.count == 7, String( world.components.count ) )
		printWorld(world)
		world.removeEntityWithComponent(cmp!)
		XCTAssertNil(cmp)
		XCTAssert(world.components.count == 5, String( world.components.count ) )
		printWorld(world)
		world.createEntity() {newEntityID in
			CompA(withID: newEntityID )
		}
		raaLog("xxxxxxxxxxxxxxxxx")
	}
	func testCreatingAndDeletingComponent() throws {
		let world = IDComponentPopulation()
		XCTAssert(world.components.count == 0, String( world.components.count ) )
		weak var cmp:IDComponent?
		for i in 0..<6 {
			world.createEntity() {newEntityID in
				CompA(withID: newEntityID )
				if i == 3 {
					let ccc = getSecondComponent(newEntityID: newEntityID, cmp: &cmp)
					ccc
				}
			}
		}
		XCTAssertNotNil(cmp)
		XCTAssert(world.components.count == 7, String( world.components.count ) )
		printWorld(world)
		world.removeComponent(cmp!)
		XCTAssertNil(cmp)
		XCTAssert(world.components.count == 6, String( world.components.count ) )
		printWorld(world)
		world.createEntity() {newEntityID in
			CompA(withID: newEntityID )
		}
		//		world.createEntity() {newEntityID in
		//			CompA(withID: newEntityID )
		//		}
		raaLog("xxxxxxxxxxxxxxxxx")
	}

	func testPerformanceGetList() throws {
		let testCount = 2000
		suppressLogs = true
		var world = IDComponentPopulation()
		for _ in 0..<testCount {
			world.createEntity() {newEntityID in
				CompA(withID: newEntityID )
				CompB(withID: newEntityID)
			}
		}
		for _ in 0..<testCount {
			world.createEntity() {newEntityID in
				CompA(withID: newEntityID )
			}
		}
		XCTAssert(world.components.count == 3*testCount, String(world.components.count))
		self.measure {
			let lstA = world.getComponentList(withType: CompA.self)
			XCTAssert(lstA.count == 2*testCount, String(lstA.count))
			let lstB = world.getComponentList(withType: CompB.self)
			XCTAssert(lstB.count == testCount, String(lstB.count))
		}
	}
	//	func testPerformanceUpdating() throws {
	//		let testCount = 100
	//		suppressLogs = true
	//		var world = IDComponentPopulation()
	//		self.measure {
	//			XCTAssert(world.components.count == 0)
	//			for _ in 0..<testCount {
	//				world.createEntity() {newEntityID in
	//					CompA(withID: newEntityID )
	//				}
	//			}
	//			XCTAssert(world.components.count == testCount, String(world.components.count))
	//			world = IDComponentPopulation()
	//			XCTAssert(world.components.count == 0)
	//		}
	//	}
}



extension IDComponentTest {
	override func setUpWithError() throws {
		suppressLogs = false
		raaLog("")
		raaLog("---->")
	}
	override func tearDownWithError() throws {
		suppressLogs = false
		raaLog("###############################")
		raaLog("")
	}
	
	func getSecondComponent(newEntityID: IDComponent.EntityID, cmp: inout IDComponent?) -> IDComponent {
		let result = CompB(withID: newEntityID)
		cmp = result
		return result
	}
}



class BaseComp: IDComponent, DBGInfo {
	let tag:String
	//
	init( withID: EntityID, withTag: String ) {
		self.tag = withTag
		super.init( withID: withID)
		raaInitInfo("\(id)")
	}
	deinit {
		raaDEINITInfo("\(id)")
	}
}


class CompA: BaseComp {
	//
	override init( withID: EntityID, withTag: String ) {
		super.init( withID: withID, withTag: withTag )
	}
}
class CompB: BaseComp {
	//
	override init( withID: EntityID, withTag: String  ) {
		super.init( withID: withID, withTag: withTag  )
	}
}

func printWorld(_ population: IDComponentPopulation) {
	raaLog(">>>>>")
	printList(components: population.components)
	raaLog("_____")
}

func printList(components: [IDComponent]) {
	for component in components {
		raaLog("id:\(component.id) - \(component)")
	}
}




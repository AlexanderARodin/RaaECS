//
//  IDComponentTest.swift
//  
//
//  Created by the Dragon on 13.02.2022.
//

import XCTest

@testable import RaaECS
//	//	//	//	//	//	//	/

enum InitConfig {
	case noneComps
	case onlyCompA
	case onlyCompB
	case doubledCompB
	case CompACompB
	case CompBCompA
}
let tstInitArray: [ InitConfig ] = [.CompBCompA, .onlyCompA, .noneComps, .doubledCompB, .CompACompB, .CompACompB, .CompBCompA, .doubledCompB, .onlyCompB]
let comparArray:  [ String ] = ["A1:1", "A2:2", "A4:4", "A5:5", "A6:6", "A9:9", "A10:10", "A12:12", "A13:13", "A14:14"]
let comparArrayOpt:  [ String ] = ["A1:1", "A2:2", "A4:3", "A5:4", "A6:5", "A9:6", "A10:7", "A12:8", "A13:9", "A14:10"]


class IDComponentTest: XCTestCase {
	//
	func testBasicAdding() throws {
		let world = IDComponentPopulation()
		XCTAssert(world.components.isEmpty)
		
		world.createEntity() {newEntityID in // 1
		}
		XCTAssert(world.components.isEmpty)
		
		world.createEntity() {newEntityID in // 1
			CompA(withID: newEntityID)
		}
		XCTAssert(world.components.count == 1)
		XCTAssert((world.components[0] as! BaseComp).info == "A1:1", (world.components[0] as! BaseComp).info)
		
		world.createEntity() {newEntityID in // 2
		}
		XCTAssert(world.components.count == 1)
		world.createEntity() {newEntityID in // 2
			CompB(withID: newEntityID)
		}
		XCTAssert(world.components.count == 2)
		XCTAssert((world.components[0] as! BaseComp).info == "A1:1", (world.components[0] as! BaseComp).info)
		XCTAssert((world.components[1] as! BaseComp).info == "B2:2", (world.components[1] as! BaseComp).info)
		world.createEntity() {newEntityID in // 3
			CompB(withID: newEntityID)
			CompB(withID: newEntityID)
		}
		XCTAssert(world.components.count == 3)
		XCTAssert((world.components[2] as! BaseComp).info == "B3:3", (world.components[2] as! BaseComp).info)
		
		//
		raaLog("")
		raaLog("_______________________________")
	}
	
	func testNormalAddingAndRemoving() throws {
		let world = IDComponentPopulation()
		for config in tstInitArray {
			world.createEntity() {newEntityID in
				getSubArray( withID: newEntityID,  config: config )
			}
		}
		XCTAssert(world.components.count == 12)
		for config in tstInitArray {
			world.createEntity() {newEntityID in
				getSubArray( withID: newEntityID,  config: config )
			}
		}
		XCTAssert(world.components.count == 24)
		
		world.removeComponents(withType: CompB.self)
		XCTAssert(world.components.count == 10)
		for i in 0..<10 {
			let cmp = world.components[i] as? BaseComp
			XCTAssertNotNil(cmp)
			XCTAssert(cmp!.info == comparArray[i], "i: \(i)\t\(cmp!.info)")
			raaLog(cmp!.info)
		}
		
		unOptimizesMaxID = 1
		world.createEntity() {newEntityID in
		}
		XCTAssert(world.components.count == 10)
		for i in 0..<10 {
			let cmp = world.components[i] as? BaseComp
			XCTAssertNotNil(cmp)
			XCTAssert(cmp!.info == comparArrayOpt[i], "i: \(i)\t\(cmp!.info)")
			raaLog(cmp!.info)
		}
		//
		raaLog("")
		raaLog("_______________________________")
	}
	
	func testPerformBasic() throws {
		let world = IDComponentPopulation()
		suppressLogs = true
		self.measure {
			for _ in 0..<100 {
				for config in tstInitArray {
					world.createEntity() {newEntityID in
						getSubArray( withID: newEntityID,  config: config )
					}
				}
			}
			XCTAssert(world.components.count == 1200)
			world.removeComponents(withType: CompB.self)
			XCTAssert(world.components.count == 500)
			//XCTAssert(world.components.last?.id == 1000, "\(world.components.last!.id)" )
			world.removeComponents(withType: IDComponent.self)
			XCTAssert(world.components.isEmpty, "\(world.components.count)" )
		}
		//
		raaLog("")
		raaLog("_______________________________")
	}
	func testPerformHard() throws {
		let world = IDComponentPopulation()
		suppressLogs = true
		unOptimizesMaxID = UInt32(UInt8.max)
		self.measure {
			for _ in 0..<100 {
				for config in tstInitArray {
					world.createEntity() {newEntityID in
						getSubArray( withID: newEntityID,  config: config )
					}
				}
			}
			XCTAssert(world.components.count == 1200)
			world.removeComponents(withType: CompB.self)
			XCTAssert(world.components.count == 500)
			//XCTAssert(world.components.last?.id == 1000, "\(world.components.last!.id)" )
			world.removeComponents(withType: IDComponent.self)
			XCTAssert(world.components.isEmpty, "\(world.components.count)" )
		}
		//
		raaLog("")
		raaLog("_______________________________")
	}
}






extension IDComponentTest {
	override func setUpWithError() throws {
		suppressLogs = false
		unOptimizesMaxID = IDComponentPopulation.EntityID.max
		raaLog("")
		raaLog("---->")
	}
	override func tearDownWithError() throws {
		suppressLogs = false
		unOptimizesMaxID = IDComponentPopulation.EntityID.max
		raaLog("###############################")
		raaLog("")
	}
	
	func getSubArray( withID: IDComponent.EntityID, config: InitConfig ) -> [IDComponent] {
		switch config {
		case .noneComps:
			return []
		case .onlyCompA:
			return [CompA(withID: withID)]
		case .onlyCompB:
			return [CompB(withID: withID)]
		case .doubledCompB:
			return [CompB(withID: withID), CompB(withID: withID)]
		case .CompACompB:
			return [CompA(withID: withID), CompB(withID: withID)]
		case .CompBCompA:
			return [CompB(withID: withID), CompA(withID: withID)]
		}
	}
}



class BaseComp: IDComponent, DBGInfo {
	let initID:EntityID
	let tag:String
	var info:String {
		get {
			tag
			+ "\(initID)"
			+ ":"
			+ (id==nil ? "nil" : "\(id!)" )
		}
	}
	//
	init( withID: EntityID, withTag: String = "" ) {
		self.initID = withID
		self.tag = withTag
		super.init( withID: withID)
		raaInitInfo("\(tag) - id\((id ?? 0))")
	}
	deinit {
		raaDEINITInfo("\(tag) - id\((id ?? 0))")
	}
}


class CompA: BaseComp {
	//
	override init( withID: EntityID, withTag: String = "" ) {
		super.init( withID: withID, withTag: "A"+withTag )
	}
}
class CompB: BaseComp {
	//
	override init( withID: EntityID, withTag: String = "" ) {
		super.init( withID: withID, withTag: "B"+withTag  )
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




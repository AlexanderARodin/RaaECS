////
////  IDComponentTest.swift
////  
////
////  Created by the Dragon on 13.02.2022.
////
//
//import XCTest
//
//@testable import RaaECS
////	//	//	//	//	//	//	/
//
//enum InitConfig {
//	case noneComps
//	case onlyCompA
//	case onlyCompB
//	case doubledCompB
//	case CompACompB
//	case CompBCompA
//}
//let tstInitArray: [ InitConfig ] = [.CompBCompA, .onlyCompA, .noneComps, .doubledCompB, .CompACompB, .CompACompB, .CompBCompA, .doubledCompB, .onlyCompB]
//let comparArray:  [ String ] = ["A1:1", "A2:2", "A4:4", "A5:5", "A6:6", "A9:9", "A10:10", "A12:12", "A13:13", "A14:14"]
//let comparArrayOpt:  [ String ] = ["A1:1", "A2:2", "A4:3", "A5:4", "A6:5", "A9:6", "A10:7", "A12:8", "A13:9", "A14:10", "B11:11"]
//let sysB_Array:  [ String ] = ["B1:1", "B3:3", "B4:4", "B5:5", "B6:6", "B7:7", "B8:8"]
//
//
//class IDComponentTest: XCTestCase {
//	//
//	func testComponentSystem() throws {
//		let world = IDComponentPopulation()
//		for config in tstInitArray {
//			world.createEntity() {
//				getSubArray( config: config )
//			}
//		}
//		let sysAB = IDComponentSystem<IDComponent>()
//		sysAB.reBuildComponentList( from: [] )
//		XCTAssert(sysAB.count == 0)
//		sysAB.reBuildComponentList( from: world.components )
//		XCTAssert(sysAB.count == 12)
//		
//		let sysA = IDComponentSystem<CompA>()
//		sysA.reBuildComponentList( from: world.components )
//		XCTAssert(sysA.count == 5)
//		
//		let sysB = IDComponentSystem<CompB>()
//		sysB.reBuildComponentList( from: world.components )
//		XCTAssert(sysB.count == 7)
//		for i in 0..<7 {
//			let cmp = sysB[i]
//			XCTAssertNotNil(cmp)
//			XCTAssert(cmp!.isValidID)
//			XCTAssert(cmp!.info == sysB_Array[i], "i: \(i)\t\(cmp!.info)")
//			raaLog(cmp!.info)
//		}
//		world.removeComponents(withType: AnyObject.self)
//		for i in 0..<7 {
//			let cmp = sysB[i]
//			XCTAssertNil(cmp)
//		}
//
//		//
//		raaLog("")
//		raaLog("_______________________________")
//	}
//	
//	func testBasicAdding() throws {
//		let world = IDComponentPopulation()
//		XCTAssert(world.components.isEmpty)
//		
//		world.createEntity() { // 1
//		}
//		XCTAssert(world.components.isEmpty)
//		
//		world.createEntity() { // 1
//			CompA()
//		}
//		XCTAssert(world.components.count == 1)
//		XCTAssert((world.components[0] as! BaseComp).info == "A1:1", (world.components[0] as! BaseComp).info)
//		
//		world.createEntity() { // 2
//		}
//		XCTAssert(world.components.count == 1)
//		world.createEntity() { // 2
//			CompB()
//		}
//		XCTAssert(world.components.count == 2)
//		XCTAssert((world.components[0] as! BaseComp).info == "A1:1", (world.components[0] as! BaseComp).info)
//		XCTAssert((world.components[1] as! BaseComp).info == "B2:2", (world.components[1] as! BaseComp).info)
//		world.createEntity() { // 3
//			CompB()
//			CompB()
//		}
//		XCTAssert(world.components.count == 3)
//		XCTAssert((world.components[2] as! BaseComp).info == "B3:3", (world.components[2] as! BaseComp).info)
//		
//		//
//		raaLog("")
//		raaLog("_______________________________")
//	}
//	
//	func testIsChanged() throws {
//		let world = IDComponentPopulation()
//		XCTAssert(world.isChanged == false)
//		
//		world.createEntity() { // 1
//		}
//		XCTAssert(world.isChanged == false)
//
//		world.createEntity() { // 1
//			CompA()
//		}
//		XCTAssert(world.isChanged == true)
//		world.createEntity() {
//		}
//		XCTAssert(world.isChanged == true)
//		world.resetIsChanged()
//		XCTAssert(world.isChanged == false)
//		world.createEntity() { // 1
//		}
//		XCTAssert(world.isChanged == false)
//		
//		world.createEntity() { // 1
//			CompA()
//		}
//		XCTAssert(world.isChanged == true)
//		
//		//
//		raaLog("")
//		raaLog("_______________________________")
//	}
//	
//	func testNormalAddingAndRemoving() throws {
//		let world = IDComponentPopulation()
//		for config in tstInitArray {
//			world.createEntity() {
//				getSubArray( config: config )
//			}
//		}
//		XCTAssert(world.components.count == 12)
//		for config in tstInitArray {
//			world.createEntity() {
//				getSubArray( config: config )
//			}
//		}
//		XCTAssert(world.components.count == 24)
//		
//		world.removeComponents(withType: CompB.self)
//		XCTAssert(world.components.count == 10)
//		for i in 0..<10 {
//			let cmp = world.components[i] as? BaseComp
//			XCTAssertNotNil(cmp)
//			XCTAssert(cmp!.info == comparArray[i], "i: \(i)\t\(cmp!.info)")
//			raaLog(cmp!.info)
//		}
//		
//		//
//		raaLog("")
//		raaLog("_______________________________")
//	}
//	
//	func testOptimizing() throws {
//		let world = IDComponentPopulation()
//		for config in tstInitArray {
//			world.createEntity() {
//				getSubArray( config: config )
//			}
//		}
//		XCTAssert(world.components.count == 12)
//		for config in tstInitArray {
//			world.createEntity() {
//				getSubArray( config: config )
//			}
//		}
//		XCTAssert(world.components.count == 24)
//		
//		world.removeComponents(withType: CompB.self)
//		XCTAssert(world.components.count == 10)
//		for i in 0..<10 {
//			let cmp = world.components[i] as? BaseComp
//			XCTAssertNotNil(cmp)
//			XCTAssert(cmp!.info == comparArray[i], "i: \(i)\t\(cmp!.info)")
//			raaLog(cmp!.info)
//		}
//		
//		unOptimizesMaxID = 1
//		world.createEntity() {
//			CompB()
//		}
//		XCTAssert(world.components.count == 11)
//		for i in 0..<10 {
//			let cmp = world.components[i] as? BaseComp
//			XCTAssertNotNil(cmp)
//			XCTAssert(cmp!.info == comparArrayOpt[i], "i: \(i)\t\(cmp!.info)")
//			raaLog(cmp!.info)
//		}
//		//
//		raaLog("")
//		raaLog("_______________________________")
//	}
//	
//	func testPerformBasic() throws {
//		let world = IDComponentPopulation()
//		suppressLogs = true
//		self.measure {
//			for _ in 0..<100 {
//				for config in tstInitArray {
//					world.createEntity() {
//						getSubArray(config: config )
//					}
//				}
//			}
//			XCTAssert(world.components.count == 1200)
//			world.removeComponents(withType: CompB.self)
//			XCTAssert(world.components.count == 500)
//			//XCTAssert(world.components.last?.id == 1000, "\(world.components.last!.id)" )
//			world.removeComponents(withType: IDComponent.self)
//			XCTAssert(world.components.isEmpty, "\(world.components.count)" )
//		}
//		//
//		raaLog("")
//		raaLog("_______________________________")
//	}
//	func testPerformHard() throws {
//		let world = IDComponentPopulation()
//		suppressLogs = true
//		unOptimizesMaxID = UInt32(UInt8.max)
//		self.measure {
//			for _ in 0..<100 {
//				for config in tstInitArray {
//					world.createEntity() {
//						getSubArray( config: config )
//					}
//				}
//			}
//			XCTAssert(world.components.count == 1200)
//			world.removeComponents(withType: CompB.self)
//			XCTAssert(world.components.count == 500)
//			//XCTAssert(world.components.last?.id == 1000, "\(world.components.last!.id)" )
//			world.removeComponents(withType: IDComponent.self)
//			XCTAssert(world.components.isEmpty, "\(world.components.count)" )
//		}
//		//
//		raaLog("")
//		raaLog("_______________________________")
//	}
//}
//
//
//
//
//
//
//extension IDComponentTest {
//	override func setUpWithError() throws {
//		suppressLogs = false
//		unOptimizesMaxID = IDComponentPopulation.EntityID.max
//		raaLog("")
//		raaLog("---->")
//	}
//	override func tearDownWithError() throws {
//		suppressLogs = false
//		unOptimizesMaxID = IDComponentPopulation.EntityID.max
//		raaLog("###############################")
//		raaLog("")
//	}
//	
//	func getSubArray( config: InitConfig ) -> [IDComponent] {
//		switch config {
//		case .noneComps:
//			return []
//		case .onlyCompA:
//			return [CompA()]
//		case .onlyCompB:
//			return [CompB()]
//		case .doubledCompB:
//			return [CompB(), CompB()]
//		case .CompACompB:
//			return [CompA(), CompB()]
//		case .CompBCompA:
//			return [CompB(), CompA()]
//		}
//	}
//}
//
//
//
//class BaseComp: IDComponent, DBGInfo {
//	override func onChangeID(from oldID: IDComponent.EntityID?, to newID: IDComponent.EntityID?) {
//		if oldID == nil, let newID = newID, initID == 0 {
//			//raaLog(tag + "Ok-k-k..")
//			initID = newID
//		}else{
//			//raaLog(tag + "\t\(oldID) -> \(newID)\t!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
//		}
//	}
//	var initID:EntityID = 0
//	let tag:String
//	var info:String {
//		get {
//			tag
//			+ "\(initID)"
//			+ ":"
//			+ (id==nil ? "nil" : "\(id!)" )
//		}
//	}
//	//
//	init( withTag: String = "" ) {
//		self.tag = withTag
//		super.init()
//		raaInitInfo("\(tag) - id\((id ?? 0))")
//	}
//	deinit {
//		raaDEINITInfo("\(tag) - id\((id ?? 0))")
//	}
//}
//
//
//class CompA: BaseComp {
//	//
//	override init( withTag: String = "" ) {
//		super.init( withTag: "A"+withTag )
//	}
//}
//class CompB: BaseComp {
//	//
//	override init( withTag: String = "" ) {
//		super.init( withTag: "B"+withTag  )
//	}
//}
//
//
//

import XCTest

@testable import RaaECS
//	//	//	//	//	//	//	/


final class RaaECSTests_2: XCTestCase {
	func testEntityPopulation() throws {
		let population = RaaEntityPopulation()
		XCTAssert(population.entities.count == 0, "count not ZERO")
		population.createEntityFromComponents() {_ in
		}
		XCTAssert(population.entities.count == 0, "count not ZERO")
		population.createEntityFromComponents() {newEntity in
			BaseRaaComponent(forEntity: RaaEntity())
		}
		population.createEntityFromComponents() {newEntity in
			BaseRaaComponent(forEntity: newEntity)
		}
		XCTAssert(population.entities.count == 1, "count not 1 but \(population.entities.count)")
		raaLog("removeAllEntities...")
		population.removeAllEntities()
		XCTAssert(population.entities.count == 0, "count not ZERO")
	}
}


let n:Int = 100
extension RaaECSTests_2 {
	func testPerformanceCreating() throws {
		// This is an example of a performance test case.
		suppressLogs = true
		let population = RaaEntityPopulation()
		self.measure {
			// Put the code you want to measure the time of here.
			for _ in 0..<n {
				population.createEntityFromComponents() {newEntity in
					BaseRaaComponent(forEntity: newEntity)
					BaseRaaComponent(forEntity: newEntity)
					BaseRaaComponent(forEntity: newEntity)
					PseudoComponent(forEntity: newEntity)
				}
				XCTAssert(population.entities.first?.components.count == 2, "there are doubled components")
			}
		}
		XCTAssert(population.entities.count == n*10, "count not \(n*10) but \(population.entities.count)")
		population.removeAllEntities()
		XCTAssert(population.entities.count == 0, "count not ZERO")
	}
	func testPerformanceUpdating() throws {
		// This is an example of a performance test case.
		suppressLogs = true
		let population = RaaEntityPopulation()
		for _ in 0..<(n*10) {
			population.createEntityFromComponents() {newEntity in
				BaseRaaComponent(forEntity: newEntity)
				BaseRaaComponent(forEntity: newEntity)
				BaseRaaComponent(forEntity: newEntity)
				PseudoComponent(forEntity: newEntity)
			}
			XCTAssert(population.entities.first?.components.count == 2, "there are doubled components")
		}
		suppressLogs = false
		self.measure {
			// Put the code you want to measure the time of here.
			population.sendUpdateWithDeltaTime(seconds: -1, forType: PseudoComponent.self)
			population.sendUpdateWithDeltaTime(seconds: -1, forType: BaseRaaComponent.self)
		}
		suppressLogs = true
		XCTAssert(population.entities.count == n*10, "count not \(n*10) but \(population.entities.count)")
		population.removeAllEntities()
		XCTAssert(population.entities.count == 0, "count not ZERO")
	}
}

extension RaaECSTests_2 {
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
	
}

public class PseudoComponent: BaseRaaComponent {
	public override func update( withDeltaTime deltaTime: Double ) {raaLog("kkkkkkkk")}
}

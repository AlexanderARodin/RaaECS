//
//  DBGi.swift
//
//
//  Created by the Dragon on 11.02.2022.
//

import Foundation


//	//	//	//	//	//	//	//

let linePrefix = "raa>\t"

extension NSObject: DBGInfo {
	//
}


public protocol DBGInfo {
	func raaInitInfo()
	func raaDEINITInfo()
}
public extension DBGInfo {
	func raaInitInfo() {
		raaLog( "+ "+String(describing: type(of: self)))
	}
	func raaDEINITInfo() {
		raaLog( "- "+String(describing: type(of: self)))
	}
	var raaClassPrefix: String {
		"  " + String(describing: type(of: self)) + ":\t"
	}
}
var suppressLogs = false
public func raaLog(_ str: String) {
	guard !suppressLogs else {return}
	print(linePrefix+str)
	//	DispatchQueue.main.async {
	//		globalInfo.logs += "\n\(str)"
	//	}
}


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
	func raaInitInfo(_ extTxt: String? )
	func raaDEINITInfo(_ extTxt: String? )
}
public extension DBGInfo {
	func raaInitInfo(_ extTxt: String? = nil ) {
		let txt:String = (extTxt == nil) ? "" : "\t<\(extTxt ?? "")>"
		raaLog( "+ "+String(describing: type(of: self)) + txt )
	}
	func raaDEINITInfo(_ extTxt: String? = nil ) {
		let txt:String = (extTxt == nil) ? "" : "\t<\(extTxt ?? "")>"
		raaLog( "- "+String(describing: type(of: self)) + txt )
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


//
//  Dict+Extension.swift
//  MandiriDummyProject
//
//  Created by Jehnsen Hirena Kane on 13/04/23.
//

import Foundation

public func + <KeyType, ValueType> (left: [KeyType: ValueType], right: [KeyType: ValueType]) -> [KeyType: ValueType] {
  var out = left

  for (k, v) in right {
    out.updateValue(v, forKey: k)
  }

  return out
}

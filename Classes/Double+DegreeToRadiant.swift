//
//  Double+DegreeToRadiant.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 31.10.19.
//  Copyright © 2019 Jeanette Müller. All rights reserved.
//

import Foundation

public extension Double {

    func degreesToRadians() -> CGFloat {
        return CGFloat((Double.pi * self) / 180)
    }

}

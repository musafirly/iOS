//
//  CLLocation2DExtension.swift
//  Musafirly
//
//  Created by Anthony on 5/8/25.
//

import CoreLocation


extension CLLocationCoordinate2D: @retroactive Equatable{
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

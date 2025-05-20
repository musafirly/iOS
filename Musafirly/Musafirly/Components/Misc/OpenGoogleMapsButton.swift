//
//  OpenGoogleMapsButton.swift
//  Musafirly
//
//  Created by Anthony on 5/20/25.
//

import SwiftUI


struct OpenGoogleMapsButton: View {
    let lat: CGFloat
    let lon: CGFloat
    let mapsUrl: String
    
    /// Creates a button that tries to open a link to Google Maps using the data supplied. If GMaps is not installed, it will open it in the browser.
    /// Please pass in the exact string that was given by the Musafirly API. AKA, the one with the HTTPS protocol.
    init(_ withLatitude: CGFloat, _ withLongitude: CGFloat, backupMapsUrl: String) {
        self.lat = withLatitude
        self.lon = withLongitude
        self.mapsUrl = backupMapsUrl
    }
    
    
    var body: some View {
        Button(action: {
            let processedUrl = "comgooglemapsurl://\(mapsUrl)"
            
            let gmapUrl = URL(string: processedUrl)!
            
            if UIApplication.shared.canOpenURL(gmapUrl) {
                UIApplication.shared.open(gmapUrl, options: [:], completionHandler: nil)
            } else {
                let urlBrowser = URL(string: mapsUrl)
                                 
                UIApplication.shared.open(urlBrowser!, options: [:], completionHandler: nil)
            }
            
        } ) {
            HStack {
                Image(systemName: "map.circle")
                Text("Open in Google Maps")
            }
            .foregroundStyle(Color.white)
        }
        .tint(Color.googleMapsButton)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 20))
    }
}

#Preview {
    OpenGoogleMapsButton(0.0, 0.0, backupMapsUrl: "")
}

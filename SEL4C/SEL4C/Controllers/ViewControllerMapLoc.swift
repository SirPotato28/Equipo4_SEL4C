//
//  ViewControllerMapLoc.swift
//  SEL4C
//
//  Created by Usuario on 07/10/23.
//

import UIKit
import MapKit

class ViewControllerMapLoc: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    var distanciaRecorrida = 0.0
    var posicionInicial: CLLocation? = nil
    var posicionFinal: CLLocation? = nil
    let radioRegion: CLLocationDistance = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        } else {
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if posicionInicial == nil {
            posicionInicial = locationManager.location
            centerMapOnLocation(location: posicionInicial!)
            posicionFinal = posicionInicial
            
            var punto = CLLocationCoordinate2D()
            punto.latitude = posicionInicial!.coordinate.latitude
            punto.longitude = posicionInicial!.coordinate.longitude
            
            let annotation = MKPointAnnotation()
            annotation.title = "Longituds: \(posicionInicial!.coordinate.longitude) Latitud: \(posicionInicial!.coordinate.latitude)"
            annotation.subtitle = "Distancia recorrida: 0 metros"
            annotation.coordinate = punto
            
            mapView.addAnnotation(annotation)
        } else {
            posicionInicial = locationManager.location
            centerMapOnLocation(location: posicionInicial!)
            let distance = posicionFinal?.distance(from: posicionInicial!)
            
            if distance! >= 50{
                distanciaRecorrida += distance!
                
                posicionFinal = posicionInicial
                var punto = CLLocationCoordinate2D()
                punto.latitude = posicionInicial!.coordinate.latitude
                punto.longitude = posicionInicial!.coordinate.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = "Longitud: \(posicionInicial!.coordinate.longitude) Latitud: \(posicionInicial!.coordinate.latitude)"
                annotation.subtitle = "Distancia recorrida: \(Int(distanciaRecorrida)) metros"
                annotation.coordinate = punto
                
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: radioRegion * 2.0, longitudinalMeters: radioRegion * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

}

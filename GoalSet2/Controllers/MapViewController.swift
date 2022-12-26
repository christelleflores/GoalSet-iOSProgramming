//
//  MapViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/4/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var recievingLocation: String = ""
    let regionRadius: CLLocationDistance = 1000
    var matchingSearchItems: [MKMapItem] = [MKMapItem]()
    @IBOutlet weak var segmentedControlMapType: UISegmentedControl!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textfieldLocation: UITextField!
    
    //pinch to zoom in and out
    @IBAction func pinchgesture(_ sender: Any) {
        print("pinch gesture")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textfieldLocation.text = recievingLocation
        zoomInOnQuinnipiac()
    }
    
    func zoomInOnQuinnipiac() {
        let myLocation = CLLocation(latitude: 41.41992, longitude: -72.89771)
        let myRegion = MKCoordinateRegion(center: myLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(myRegion, animated: true)
    }
    
    @IBAction func mapTypeChange(_ sender: Any) {
        if segmentedControlMapType.selectedSegmentIndex == 1 {
            mapView.mapType = MKMapType.satellite
        } else {
            mapView.mapType = MKMapType.standard
        }
    }
    
    @IBAction func searchMap(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = textfieldLocation!.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("An error occurred")
            } else if response!.mapItems.count == 0 {
                print("Nothing was returned")
            } else {
                print("We got results")
                for item in response!.mapItems {
                    // Process the results into our array
                    self.matchingSearchItems.append(item as MKMapItem)
                    
                    // Drop the pin on the map...
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


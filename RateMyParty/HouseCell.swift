import UIKit
import CoreLocation
import MapKit

class HouseCell: UITableViewCell {
    //@IBOutlet var addressLabel: UILabel!
    @IBOutlet var houseNameLabel: UILabel!
    @IBOutlet var houseImageView: UIImageView!
    @IBOutlet var walkDirectionsButton: UIButton!
    @IBOutlet var driveDirectionsButton: UIButton!
    var locationManager: CLLocationManager!
    var houseLocation:CLLocation?
    
    @IBAction func getDirectionsToHouseWalk() {
        println("button pressed")
        var placemark = MKPlacemark(coordinate: houseLocation!.coordinate, addressDictionary: nil)
        var currentLocation = MKPlacemark(coordinate: locationManager.location.coordinate , addressDictionary: nil)
        let mapItems = [MKMapItem(placemark: placemark), MKMapItem(placemark: currentLocation)]
        
        let options = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving,
            MKLaunchOptionsShowsTrafficKey: true]
        
        MKMapItem.openMapsWithItems(mapItems, launchOptions: options as [NSObject : AnyObject])
        
    }
    
    @IBAction func getDirectionsToHouseDrive() {
        var placemark = MKPlacemark(coordinate: houseLocation!.coordinate, addressDictionary: nil)
        var house = MKMapItem(placemark: placemark)
        var launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking]
        house.openInMapsWithLaunchOptions(launchOptions)
    }

}

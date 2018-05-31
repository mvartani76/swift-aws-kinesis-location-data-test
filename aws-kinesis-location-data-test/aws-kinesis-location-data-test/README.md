# iOS Example App

## Initialize AWS Credentials under didFinishLaunchingWithOptions in AppDelegate.swift

```javascript
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        AWSDDLog.sharedInstance.logLevel = .all
        
        NSLog("Configuring Credentials...")
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: AwsRegion, identityPoolId: CognitoIdentityPoolId)
        
        let configuration = AWSServiceConfiguration(
            region: AwsRegion,
            credentialsProvider: credentialProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
                
        return true
    }
```
## Use FirehoseRecorder in ViewController.swift

Initialize firehose recorder under locationManager
```javascript
let fireHoseRecorder = AWSFirehoseRecorder.default()
```
Save the Kinesis Firehose Records Locally
```javascript
// Save the kinesis firehose records locally
 fireHoseRecorder.saveRecord(dateString.data(using: String.Encoding.utf8), streamName: MyStreamName)
 fireHoseRecorder.saveRecord(",".data(using: String.Encoding.utf8), streamName: MyStreamName)
 fireHoseRecorder.saveRecord(latLabel.text?.data(using: String.Encoding.utf8), streamName: MyStreamName)
 fireHoseRecorder.saveRecord(",".data(using: String.Encoding.utf8), streamName: MyStreamName)
 fireHoseRecorder.saveRecord(lonLabel.text?.data(using: String.Encoding.utf8), streamName: MyStreamName)
 fireHoseRecorder.saveRecord("\n".data(using: String.Encoding.utf8), streamName: MyStreamName)
```
Submit all records after DataCountThreshold times collecting data
```javascript
if dataCount > DataCountThreshold {
     fireHoseRecorder.submitAllRecords()
     dataCount = 0
}

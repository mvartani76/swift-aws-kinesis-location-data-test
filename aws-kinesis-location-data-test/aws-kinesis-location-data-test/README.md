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
```
## Add Location/Privacy Requirements and AWS Settings in info.plist

### Location/Privacy Requirements
```javascript
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string></string>
<key>NSLocationAlwaysUsageDescription</key>
<string></string>
<key>NSLocationWhenInUseUsageDescription</key>
<string></string>
```
### AWS Settings
```javascript
        <key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>amazonaws.com</key>
			<dict>
				<key>NSThirdPartyExceptionMinimumTLSVersion</key>
				<string>TLSv1.0</string>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
				<key>NSIncludesSubdomains</key>
				<true/>
			</dict>
			<key>amazonaws.com.cn</key>
			<dict>
				<key>NSThirdPartyExceptionMinimumTLSVersion</key>
				<string>TLSv1.0</string>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
				<key>NSIncludesSubdomains</key>
				<true/>
			</dict>
		</dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
	<key>AWS</key>
	<dict>
		<key>CredentialsProvider</key>
		<dict>
			<key>CognitoIdentity</key>
			<dict>
				<key>Default</key>
				<dict>
					<key>PoolId</key>
					<string>REGION:ARN</string>
					<key>Region</key>
					<string>REGION</string>
				</dict>
			</dict>
		</dict>
		<key>S3TransferUtility</key>
		<dict>
			<key>Default</key>
			<dict>
				<key>Region</key>
				<string>REGION</string>
			</dict>
		</dict>
	</dict>
```

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

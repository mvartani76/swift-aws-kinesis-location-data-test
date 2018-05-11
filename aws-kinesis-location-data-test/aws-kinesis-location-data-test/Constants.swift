//
//  Constants.swift
//  aws-kinesis-location-data-test
//
//  Created by Michael Vartanian on 4/26/18.
//  Copyright © 2018 Michael Vartanian. All rights reserved.
//

import Foundation
import AWSCore

//WARNING: To run this sample correctly, you must set the following constants.
let AwsRegion = AWSRegionType.USWest2
let CognitoIdentityPoolId = "Your Cognito Federated Identity ID"
let LocationManagerDistanceFilter = 5.0
let DataCountThreshold = 20
let MyStreamName = "Your Kinesis Firehose Stream Name"

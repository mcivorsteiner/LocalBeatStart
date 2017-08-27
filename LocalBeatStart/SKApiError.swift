//
//  SKApiError.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 8/26/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation

enum SKApiError: Error {
    case responseContentsError
    case responseMappingError
    case unknownError
    case requestError
}

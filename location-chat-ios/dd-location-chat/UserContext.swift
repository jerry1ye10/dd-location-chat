//
//  GCMaker.swift
//  dd-location-chat
//
//  Created by Sebastien La Duca on 4/7/22.
//

struct UserContextData {
	var userID: String
	var communityID: String?
	var currentCity: String?

	init(_userID: String) {
		userID = _userID
	}

	getRemoteData(cb: (error: String?) -> Void) {
		let url = NSURL("FIREBASE_DOCUMENT_URL")
		let request = NSURLRequest(url)
		// TODO: populate request with stuff

		let queue = NSOperationQueue()
		NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {(response, data, error) -> Void in
			guard let data = data else {
				cb(error)
				return
			}

			// TODO how to decode data into communityID and currentCity

			communityID = data.communityID
			curentCity = data.currentCity
			cb(nil)
		})
	}
}

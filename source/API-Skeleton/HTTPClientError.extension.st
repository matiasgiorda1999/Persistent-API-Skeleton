Extension { #name : #HTTPClientError }

{ #category : #'*API-Skeleton' }
HTTPClientError >> asJRPCJSON [

	^ super asJRPCJSON
		  at: 'code' put: self code asString;
		  yourself
]

{ #category : #'*API-Skeleton' }
HTTPClientError >> asJRPCResponseWithId: anInteger [

	^ self code = 422
		then: [ 
			| response |
			response := JRPCErrorResponseObject id: anInteger error: JRPCErrorObject invalidParams.
			response error message: self messageText.
			response
			]
		otherwise: [ super asJRPCResponseWithId: anInteger ]
]

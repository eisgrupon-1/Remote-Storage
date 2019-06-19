Class {
	#name : #FileDownloadController,
	#superclass : #Object,
	#instVars : [
		'fileManagementSystem',
		'server'
	],
	#category : #'RemoteStorage-Model-API'
}

{ #category : #'Instance Creation' }
FileDownloadController class >> within: aFileManagementSystem [
	^ self new initializeWithin: aFileManagementSystem
]

{ #category : #initialization }
FileDownloadController >> configureServerResponseHeaders [
	server
		after:
			'/*'
				-> [ :req :res | 
					res headers
						at: 'Accept' put: '*/*';
						at: 'Access-Control-Allow-Origin' put: '*';
						at: 'Access-Control-Allow-Headers' put: '*';
						at: 'Access-Control-Allow-Methods' put: 'POST'.
					res ];
		when: [ :req | true ]
]

{ #category : #initialization }
FileDownloadController >> handleFileDownloadRequest: request [
	| uuid |
	uuid := request at: #identifier.
	fileManagementSystem getAllFiles
		detect: [ :file | file uuid asString = uuid ]
		ifFound: [ :file | 
			^ ZnResponse
				ok: (ZnEntity bytes: file fileReference readStream upToEnd) ]
		ifNone: [ ^ ZnResponse badRequest: request ]
]

{ #category : #initialization }
FileDownloadController >> initializeServer [
	server := Teapot
		configure:
			{(#port -> 6791).
			(#debugMode -> true).
			(#bindAddress -> #[127 0 0 1])}.
	self configureServerResponseHeaders.
	server
		any:
			'/download/<identifier>/<filename>'
				-> [ :req | 
					req method = 'OPTIONS'
						ifFalse: [ self handleFileDownloadRequest: req ] ]
]

{ #category : #initialization }
FileDownloadController >> initializeWithin: aFileManagementSystem [
	fileManagementSystem := aFileManagementSystem.
	self initializeServer
]

{ #category : #accessing }
FileDownloadController >> start [
	server start
]

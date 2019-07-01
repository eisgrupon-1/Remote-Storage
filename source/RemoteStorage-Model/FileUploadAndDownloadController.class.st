Class {
	#name : #FileUploadAndDownloadController,
	#superclass : #Object,
	#instVars : [
		'fileManagementSystem',
		'server'
	],
	#category : #'RemoteStorage-Model-API'
}

{ #category : #'Instance Creation' }
FileUploadAndDownloadController class >> within: aFileManagementSystem [
	^ self new initializeWithin: aFileManagementSystem
]

{ #category : #initialization }
FileUploadAndDownloadController >> configureServerResponseHeaders [
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
FileUploadAndDownloadController >> handleFileDownloadRequest: request [
	| uuid |
	uuid := [ request at: #identifier ]
		on: Error
		do: [ :signal | request uri pathSegments last asString ].
	fileManagementSystem getAllFiles
		detect: [ :file | file uuid asString = uuid ]
		ifFound: [ :file | 
			^ ZnResponse
				ok: (ZnEntity bytes: file fileReference readStream wrappedStream upToEnd) ]
		ifNone: [ ^ ZnResponse badRequest: request ]
]

{ #category : #initialization }
FileUploadAndDownloadController >> handleFileUploadRequest: request [
	| part newFile |
	(request hasEntity
		and: [ request contentType matches: ZnMimeType multiPartFormData ])
		ifFalse: [ ^ ZnResponse badRequest: request ].
	part := request entity
		partNamed: #file
		ifNone: [ ^ ZnResponse badRequest: request ].
	newFile := part entity.
	newFile notNil
		ifFalse: [ ^ ZnResponse badRequest: request ].
	fileManagementSystem
		writeFileNamed: part fileName
		withContents: newFile readStream contents.
	^ ZnResponse redirect: #upload
]

{ #category : #initialization }
FileUploadAndDownloadController >> initializeServer [
	server := Teapot
		configure:
			{(#port -> 6790).
			(#debugMode -> true).
			(#bindAddress -> #[127 0 0 1])}.
	self configureServerResponseHeaders.
	server
		any:
			'/upload'
				-> [ :req | 
					req method ~= 'OPTIONS'
						ifTrue: [ self handleFileUploadRequest: req ] ];
		any:
			'/download/<identifier>/<filename>'
				-> [ :req | 
					req method ~= 'OPTIONS'
						ifTrue: [ self handleFileDownloadRequest: req ] ]
]

{ #category : #initialization }
FileUploadAndDownloadController >> initializeWithin: aFileManagementSystem [
	fileManagementSystem := aFileManagementSystem.
	self initializeServer
]

{ #category : #initialization }
FileUploadAndDownloadController >> server [
	^ server
]

{ #category : #initialization }
FileUploadAndDownloadController >> start [
	server start
]

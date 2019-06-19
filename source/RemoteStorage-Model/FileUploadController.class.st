Class {
	#name : #FileUploadController,
	#superclass : #Object,
	#instVars : [
		'fileManagementSystem',
		'server'
	],
	#category : #'RemoteStorage-Model-API'
}

{ #category : #'Instance Creation' }
FileUploadController class >> within: aFileManagementSystem [
	^ self new initializeWithin: aFileManagementSystem
]

{ #category : #initialization }
FileUploadController >> configureServerResponseHeaders [
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
FileUploadController >> handleFileUploadRequest: request [
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
FileUploadController >> initializeServer [
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
					req method = 'OPTIONS'
						ifFalse: [ self handleFileUploadRequest: req ] ]
]

{ #category : #initialization }
FileUploadController >> initializeWithin: aFileManagementSystem [
	fileManagementSystem := aFileManagementSystem.
	self initializeServer
]

{ #category : #initialization }
FileUploadController >> start [
	server start
]

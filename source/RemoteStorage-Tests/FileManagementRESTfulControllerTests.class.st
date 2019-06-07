Class {
	#name : #FileManagementRESTfulControllerTests,
	#superclass : #ResourceRESTfulControllerTest,
	#instVars : [
		'fileManagementSystem'
	],
	#category : #'RemoteStorage-Tests-API'
}

{ #category : #'private - support' }
FileManagementRESTfulControllerTests >> baseUrl [
	^ 'https://api.remotestorage.net' asZnUrl
]

{ #category : #'private - support' }
FileManagementRESTfulControllerTests >> getAllFiles [
	^ resourceController
		getFilesBasedOn: (self requestToGet: self resourceUrl accepting: '*/*')
		within: self newHttpRequestContext
]

{ #category : #'private - support' }
FileManagementRESTfulControllerTests >> requestToGet: anUrl accepting: anAcceptHeader [
	^ TeaRequest
		fromZnRequest:
			((ZnRequest get: anUrl)
				setAccept: anAcceptHeader;
				yourself)
]

{ #category : #'private - support' }
FileManagementRESTfulControllerTests >> setUpResourceController [
	fileManagementSystem := FileManagementSystem new.
	resourceController := FileManagementRESTfulController
		within: fileManagementSystem
]

{ #category : #'private - support' }
FileManagementRESTfulControllerTests >> testGetFilesWhenEmptyfiles [
	| response |
	response := self getAllFiles.
	self
		assert: response isSuccess;
		assert: response status equals: 200;
		assert: response contentType asMediaType
			equals: 'application/vnd.remotestorage.file+json;version=1.0.0' asMediaType.
	self
		withJsonFromContentsIn: response
		do: [ :files | self assert: files isEmpty ]
]

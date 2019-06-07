Class {
	#name : #FileManagementRESTfulControllerSpecification,
	#superclass : #ResourceRESTfulControllerSpecification,
	#category : #'RemoteStorage-Model-API'
}

{ #category : #'as yet unclassified' }
FileManagementRESTfulControllerSpecification >> addJsonObjectivesVersion1dot0MappingIn: aBuilder [
	aBuilder
		addDefaultRuleToEncode: self filesMappingKey
		to: self fileVersion1dot0dot0MediaType
		using: [ :resource :context | 
			String
				streamContents: [ :stream | 
					(NeoJSONWriter on: stream)
						for: RSFile
							do: [ :mapping | 
							mapping
								mapAccessors: #(#name #sizeAsBytes);
								mapAsHypermediaControls: [ :file | context hypermediaControlsFor: file ] ];
						nextPut: resource ] ]
]

{ #category : #'as yet unclassified' }
FileManagementRESTfulControllerSpecification >> endpoint [
	^ '/rsfiles'
]

{ #category : #'as yet unclassified' }
FileManagementRESTfulControllerSpecification >> fileTemplate [
	^ '<1s>/%<<2s>:IsUUID>'
		expandMacrosWith: self endpoint
		with: #identifier
]

{ #category : #'as yet unclassified' }
FileManagementRESTfulControllerSpecification >> fileVersion1dot0dot0MediaType [
	^ 'application/vnd.remotestorage.file+json;version=1.0.0' asMediaType
]

{ #category : #'as yet unclassified' }
FileManagementRESTfulControllerSpecification >> filesMappingKey [
	^ 'rsfiles'
]

{ #category : #'as yet unclassified' }
FileManagementRESTfulControllerSpecification >> getFilesRoute [
	^ RouteSpecification
		handling: #GET
		at: self endpoint
		evaluating:
			[ :service :httpRequest :context | service getFilesBasedOn: httpRequest within: context ]
]
